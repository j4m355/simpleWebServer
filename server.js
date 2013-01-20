var express = require('express');
var http = require('http');
var toolbox = require('toolbox');

var app = express();
var server = http.createServer(app);

var logger = function(req, res, next) {
    console.log(req.method + ': ' + req.url);
    next();
}


app.configure(function(){
    app.use(logger);
    app.use(express.static('../'));
});

var port = toolbox.getRandomNum(8000, 9999);

server.listen(port);

console.log('simpleWebServer listening at http://localhost:%s', port);
