const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World Docker!')
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})

/*
var http = require('http');

http.createServer(function (req, res) {
res.writeHead(200, {'Content-Type': 'text/html'});
res.end('Hello World!');
}).listen(8080);
*/