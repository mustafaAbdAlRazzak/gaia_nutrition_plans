import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
const STRIPE_SECRET = Deno.env.get("STRIPE_SECRET");
serve(async (req)=>{
  try {
    const body = await req.json();
    const amount = body.amount ?? 1000;
    const currency = body.currency ?? "usd";
    const userId = body.user_id; // معرف المستخدم من Flutter
    if (!userId) {
      return new Response(JSON.stringify({
        error: "user_id is required"
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    const stripeResponse = await fetch("https://api.stripe.com/v1/payment_intents", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${STRIPE_SECRET}`,
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: new URLSearchParams({
        amount: amount.toString(),
        currency: currency,
        // إضافة metadata لتحديد المستخدم
        "metadata[user_id]": userId,
        "metadata[subscription_type]": "premium_monthly",
        "description": "Premium Subscription - 30 Days"
      })
    });
    const data = await stripeResponse.json();
    if (stripeResponse.ok) {
      return new Response(JSON.stringify({
        client_secret: data.client_secret,
        payment_intent_id: data.id
      }), {
        headers: {
          "Content-Type": "application/json"
        }
      });
    } else {
      return new Response(JSON.stringify({
        error: data.error?.message || "Stripe error"
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
  } catch (e) {
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
