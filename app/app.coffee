express = require("express")
http = require("http")
toolbox = require("toolbox")





app = express()



server = http.createServer(app)
logger = (req, res, next) ->
  console.log req.method + ": " + req.url
  next()

args = []

process.argv.forEach((val, index, array)->    
    if index is 2
        args.push val
    )

app.configure ->
  app.use logger
  app.use express.static("../")
  app.use (req,res)->
    console.log "ear"
    res.setHeader("Access-Control-Allow-Origin", "http://localhost:8001")
    res.end('hmm')


port = null


if args[0] == undefined
	console.log "port " + args[0] 
	port = toolbox.getRandomNum(8000, 9999)
else
	console.log "random " + args[0]
	port = args[0]


server.listen port
console.log "simpleWebServer listening at http://localhost:%s", port