export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = url.pathname;

    if (path === "/verify") {
      return new Response(
        JSON.stringify({ status: "ok", engine: "verification", version: "1.0" }),
        { headers: { "Content-Type": "application/json" } }
      );
    }

    if (path === "/registry") {
      return new Response(
        JSON.stringify({ status: "ok", registry: ["domains", "mesh", "slots", "engines"] }),
        { headers: { "Content-Type": "application/json" } }
      );
    }

    return new Response("aiagency101.pw  agency portal online", { status: 200 });
  }
};
