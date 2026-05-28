export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = url.pathname;

    if (path === "/health") {
      return new Response(
        JSON.stringify({ status: "ok", layer: "mesh", version: "1.0" }),
        { headers: { "Content-Type": "application/json" } }
      );
    }

    return new Response("aiagency101.xyo  mesh layer placeholder (unassigned wallet)", {
      status: 200
    });
  }
};
