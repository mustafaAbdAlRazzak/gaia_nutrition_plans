import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
// استدعاء fetch عالمي في Deno
serve(async (req)=>{
  try {
    const body = await req.json();
    const searchQuery = body.searchQuery || 'apple';
    const pageNumber = body.pageNumber ?? 1;
    const pageSize = body.pageSize ?? 10;
    const apiKey = Deno.env.get("FDC_API_KEY");
    if (!apiKey) {
      return new Response(JSON.stringify({
        error: 'API key not set'
      }), {
        status: 500,
        headers: {
          'Content-Type': 'application/json'
        }
      });
    }
    const url = `https://api.nal.usda.gov/fdc/v1/foods/search?query=${encodeURIComponent(searchQuery)}&api_key=${apiKey}&pageSize=${pageSize}&pageNumber=${pageNumber}`;
    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'accept': 'application/json'
      }
    });
    if (!response.ok) {
      return new Response(JSON.stringify({
        error: `Failed to fetch: ${response.status}`
      }), {
        status: response.status,
        headers: {
          'Content-Type': 'application/json'
        }
      });
    }
    const data = await response.json();
    return new Response(JSON.stringify({
      foods: data.foods ?? []
    }), {
      status: 200,
      headers: {
        'Content-Type': 'application/json'
      }
    });
  } catch (e) {
    return new Response(JSON.stringify({
      error: e.message
    }), {
      status: 500,
      headers: {
        'Content-Type': 'application/json'
      }
    });
  }
});
