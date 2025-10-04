import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";
// استدعاء الـ Supabase client باستخدام ENV variables
const supabaseUrl = Deno.env.get("SUPABASE_URL");
const supabaseKey = Deno.env.get("SERVICE_ROLE_KEY");
const supabase = createClient(supabaseUrl, supabaseKey);
serve(async (req)=>{
  try {
    const body = await req.json();
    const userId = body.userId; // نتوقع إرسال userId من العميل
    if (!userId) {
      return new Response(JSON.stringify({
        error: "userId is required"
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    // حذف الملف الشخصي
    const { error: deleteProfileError } = await supabase.from("profiles").delete().eq("id", userId);
    if (deleteProfileError) {
      return new Response(JSON.stringify({
        error: deleteProfileError.message
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    // حذف المستخدم من auth
    const { error: deleteUserError } = await supabase.auth.admin.deleteUser(userId);
    if (deleteUserError) {
      return new Response(JSON.stringify({
        error: deleteUserError.message
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    return new Response(JSON.stringify({
      message: "User deleted successfully"
    }), {
      status: 200,
      headers: {
        "Content-Type": "application/json"
      }
    });
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
