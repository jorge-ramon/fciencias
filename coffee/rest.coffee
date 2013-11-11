express = require 'express'

app = express()

app.configure ->
    app.use express.logger()
    app.use express.bodyParser()
    app.set 'views', __dirname + "/views"
    app.engine 'html', require('ejs').renderFile


app.get '/index', (request, response) ->
    response.render 'inicio.html'

app.listen 8080









