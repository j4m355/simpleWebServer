express = require("express")
http = require("http")
toolbox = require("toolbox")
app = express()
server = http.createServer(app)
logger = (req, res, next) ->
  console.log req.method + ": " + req.url
  next()

app.configure ->
  app.use logger
  app.use express.static("../")

port = toolbox.getRandomNum(8000, 9999)
server.listen port
console.log "simpleWebServer listening at http://localhost:%s", port