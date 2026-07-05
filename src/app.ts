import http from "node:http";

const PORT = 3000;

function bootstrap() {
  const server = http.createServer((req, res) => {
    const { method, url } = req;

    if (method === "GET" && url === "/") {
      res.writeHead(200, { "Content-Type": "application/json" });
      res.end(
        JSON.stringify({ message: "Hello Github actions UPDATE 3 (By Mazen)" }),
      );
      return;
    }

    if (method === "GET" && url === "/message2") {
      res.writeHead(200, { "Content-Type": "application/json" });
      res.end(JSON.stringify({ message: "new message" }));
      return;
    }

    res.writeHead(404, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ error: "Not Found" }));
  });

  server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
  });
}

bootstrap();
