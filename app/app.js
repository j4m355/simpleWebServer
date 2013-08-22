var toolbox = require("toolbox");

var http = require("http");
var connect = require('connect');

var app = connect()

    .use(connect.logger('dev'))

    .use(connect.static('../'))

    .use(function(req, res){

      res.setHeader("Access-Control-Allow-Origin", "http://localhost:4444");
      res.end('hello world\n');

    });

var port = null;

if (args[0] == undefined)
{
  console.log("port " + args[0] );
  port = toolbox.getRandomNum(8000, 9999);
}  
else
{
  console.log("random " + args[0]);
  port = args[0];
}


var server = http.createServer(app);

server.listen(port, function () {
    console.log("simpleWebServer listening at http://localhost:%s", port);
});