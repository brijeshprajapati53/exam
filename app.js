const express = require("express");
const app = express();

const PORT = process.env.PORT || 5050;

app.get("/", (req, res) => {
  res.send("Welcome to the Node.js App on port 5050!");
});

app.listen(PORT, () => {
  console.log(`🚀 Server is running at http://localhost:${PORT}`);
});
