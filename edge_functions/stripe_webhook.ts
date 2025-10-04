import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.3";
const STRIPE_WEBHOOK_SECRET = Deno.env.get("STRIPE_WEBHOOK_SECRET");
const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
serve(async (req)=>{
  try {
    console.log("📨 Webhook received - Method:", req.method);
    const signature = req.headers.get("stripe-signature");
    if (!signature) {
      console.error("❌ No stripe-signature header found");
      return new Response(JSON.stringify({
        error: "No signature found"
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    const body = await req.text();
    console.log("📦 Request body length:", body.length);
    // التحقق من Stripe signature
    const event = await verifyStripeWebhook(body, signature);
    if (!event) {
      console.error("❌ Signature verification failed");
      return new Response(JSON.stringify({
        error: "Invalid signature"
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    console.log("✅ Signature verified - Event type:", event.type);
    // معالجة payment_intent.succeeded
    if (event.type === "payment_intent.succeeded") {
      const paymentIntent = event.data.object;
      const userId = paymentIntent.metadata?.user_id;
      console.log("💰 Payment succeeded for user:", userId);
      if (!userId) {
        console.error("❌ No user_id found in metadata");
        return new Response(JSON.stringify({
          error: "No user_id in metadata"
        }), {
          status: 400,
          headers: {
            "Content-Type": "application/json"
          }
        });
      }
      // إنشاء Supabase client
      const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
      // حساب تاريخ انتهاء الاشتراك (30 يوم من الآن)
      const expiryDate = new Date();
      expiryDate.setDate(expiryDate.getDate() + 30);
      console.log("📅 Setting expiry date to:", expiryDate.toISOString());
      const { data, error } = await supabase.from("profiles").update({
        subscription_expiry: expiryDate.toISOString(),
        updated_at: new Date().toISOString()
      }).eq("id", userId);
      if (error) {
        console.error("❌ Database error:", JSON.stringify(error));
        return new Response(JSON.stringify({
          error: "Failed to update profile",
          details: error.message
        }), {
          status: 500,
          headers: {
            "Content-Type": "application/json"
          }
        });
      }
      console.log("✅ Successfully updated subscription for user:", userId);
    }
    return new Response(JSON.stringify({
      received: true,
      event_type: event.type
    }), {
      status: 200,
      headers: {
        "Content-Type": "application/json"
      }
    });
  } catch (e) {
    console.error("💥 Webhook error:", e.message);
    return new Response(JSON.stringify({
      error: e.message
    }), {
      status: 500,
      headers: {
        "Content-Type": "application/json"
      }
    });
  }
});
async function verifyStripeWebhook(body, signature) {
  try {
    const encoder = new TextEncoder();
    const parts = signature.split(",");
    const timestamp = parts.find((p)=>p.startsWith("t="))?.split("=")[1];
    const expectedSig = parts.find((p)=>p.startsWith("v1="))?.split("=")[1];
    if (!timestamp || !expectedSig) {
      console.error("❌ Missing timestamp or signature in header");
      return null;
    }
    const payload = `${timestamp}.${body}`;
    const key = await crypto.subtle.importKey("raw", encoder.encode(STRIPE_WEBHOOK_SECRET), {
      name: "HMAC",
      hash: "SHA-256"
    }, false, [
      "sign"
    ]);
    const signature_bytes = await crypto.subtle.sign("HMAC", key, encoder.encode(payload));
    const actualSig = Array.from(new Uint8Array(signature_bytes)).map((b)=>b.toString(16).padStart(2, "0")).join("");
    if (actualSig !== expectedSig) {
      console.error("❌ Signature mismatch!");
      return null;
    }
    return JSON.parse(body);
  } catch (e) {
    console.error("❌ Verification error:", e.message);
    return null;
  }
}
