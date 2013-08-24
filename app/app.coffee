express = require("express")
http = require("http")

applyDefaults = require("./argsDefaults")
args = require("argsparser").parse()
args = applyDefaults(args)
if "help" of args and args.help
  console.log "\nUsage:"
  console.log "\n-p <port>  Sets the server port to <port>, defaults to 8000"
  console.log "\n-d <dir>   Sets the directory. Use unix paths eg /codefolder/projectfolder/"
  console.log "\n-l         Shows directories listings."
  console.log "\n-x <url>   Attaches Access-Control-Allow-Origin header for url(s)"
  console.log "\n-h/--help  Calls the police."
  console.log "\n"
  process.exit()

app = express()



server = http.createServer(app)

logger = (req, res, next) ->
  console.log req.method + ": " + req.url
  next()

if args.dir.substr(0, 1) isnt "/"
  args.dir = "/" + args.dir  if args.dir isnt ""
  args.dir = process.cwd() + args.dir

app.use express.staticCache()  if args.cache
if args.list
  app.use express.directory(args.dir,
    icons: true
  )

app.configure ->
  app.use logger
  app.use express.static(args.dir)
  app.use (req,res)->
    if args.cors
      res.setHeader("Access-Control-Allow-Origin", args.cors)
      res.end()


if args.cors
  console.log "Allowing origin: " + args.cors

server.listen args.port

console.log "staticServe serving: " + args.dir + " and listening at http://localhost:" + args.port