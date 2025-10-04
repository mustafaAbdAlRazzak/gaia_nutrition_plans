import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";
const supabaseUrl = Deno.env.get("SUPABASE_URL");
const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey);
serve(async (req)=>{
  try {
    const body = await req.json();
    const prompt = body.prompt;
    const userId = body.userId;
    if (!prompt) {
      return new Response(JSON.stringify({
        error: "Prompt is required"
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    if (!userId) {
      return new Response(JSON.stringify({
        error: "User ID is required"
      }), {
        status: 400,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    const userIdTrimmed = (userId || "").trim();
    // ✅ استخدام الاسم الصحيح للعمود
    const { data: profile, error } = await supabase.from("profiles").select("subscription_expiry").eq("id", userIdTrimmed).single();
    console.log("Supabase response data:", profile);
    console.log("Supabase error object:", error);
    if (error || !profile) {
      const detailedError = {
        message: error?.message || "User not found",
        details: error?.details,
        hint: error?.hint,
        userIdSearched: userIdTrimmed
      };
      return new Response(JSON.stringify({
        error: "User not found",
        details: detailedError
      }), {
        status: 404,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    // ✅ التأكد من الاسم الصحيح للعمود هنا أيضًا
    const subscriptionExpiry = profile.subscription_expiry ? new Date(profile.subscription_expiry) : null;
    if (!subscriptionExpiry || subscriptionExpiry < new Date()) {
      return new Response(JSON.stringify({
        error: "User subscription is not active"
      }), {
        status: 403,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    const apiKey = Deno.env.get("COHERE_API_KEY");
    if (!apiKey) {
      return new Response(JSON.stringify({
        error: "API key not set"
      }), {
        status: 500,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    const fullPrompt = `
You are a professional nutritionist AI assistant.
Your task is to generate a **complete diet plan** strictly in **valid JSON format** only. 
Do NOT include any extra text, explanations, or markdown formatting. The JSON must strictly follow this structure:

{
  "name": <string>,
  "description": <string>,
  "meals": [
    {
      "name": <string>,
      "description": <string>,
      "ingredients": [
        {
          "weight": <double>, // in grams
          "food": {
            "name": <string>,
            "protein": <num> per 100g,
            "fat": <num> per 100g,
            "carbohydrate": <num> per 100g,
            "calories": <num> per 100g
          }
        }
      ]
    }
  ]
}
User request:
${prompt}
`;
    const response = await fetch("https://api.cohere.com/v2/chat", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${apiKey}`,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        stream: false,
        model: "command-a-03-2025",
        messages: [
          {
            role: "user",
            content: fullPrompt
          }
        ]
      })
    });
    if (!response.ok) {
      return new Response(JSON.stringify({
        error: `Cohere API error: ${response.status}`
      }), {
        status: response.status,
        headers: {
          "Content-Type": "application/json"
        }
      });
    }
    const data = await response.json();
    let assistantText = data["message"]["content"][0]["text"].trim();
    if (assistantText.startsWith("```")) {
      assistantText = assistantText.substring(assistantText.indexOf("\n") + 1);
    }
    if (assistantText.endsWith("```")) {
      assistantText = assistantText.substring(0, assistantText.lastIndexOf("\n"));
    }
    const dietPlanJson = JSON.parse(assistantText);
    return new Response(JSON.stringify(dietPlanJson), {
      status: 200,
      headers: {
        "Content-Type": "application/json"
      }
    });
  } catch (e) {
    console.error("Error caught in catch block:", e);
    return new Response(JSON.stringify({
      error: e.message,
      stack: e.stack
    }), {
      status: 500,
      headers: {
        "Content-Type": "application/json"
      }
    });
  }
});
