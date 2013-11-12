express = require 'express'

mongodb = require 'mongodb'

Server = mongodb.Server

Db = mongodb.Db

server = new Server 'localhost', 27017, {auto_reconnect:true}

db = new Db 'fciencias', server

db.open (error, database) ->
	if error then console.log "Hubo un error" else console.log "Conectado a la BD"

app = express()

app.configure ->
    app.use express.logger()
    app.use express.bodyParser()
    app.use '/css', express.static __dirname + '/css'
    app.use '/bootstrap', express.static __dirname + '/bootstrap'
    app.use '/js', express.static __dirname + '/js'
    app.use '/lib', express.static __dirname + '/lib'
    app.set 'views', __dirname + "/views"
    app.engine 'html', require('ejs').renderFile


app.get '/index', (request, response) ->
    response.render 'inicio.html'

app.get '/get/:coleccion', (request, response) ->
        db.collection request.params.coleccion, (error, collection) ->
                stream = collection.find(request.query.query).stream()
                elementos = new Array()
                stream.on 'data', (item) ->
                        elementos.push item
                stream.on 'end', ->
                        response.writeHead 200, {
                                'Content-Type':'text/json'
                                'Access-Control-Allow-Origin':'*'
                                }
                        response.write 'call_' + request.params.coleccion + '(' + JSON.stringify(elementos) + ')'
                        response.end()
                        
app.post '/update/:coleccion' , (request, response) ->
        db.collection request.params.coleccion, (error, collection) ->
                collection.update request.body.query, {$set:request.body.update}, {upsert:true}, (error, resultado) ->
                        response.writeHead 200, {
                                'Content-Type':'text/plain'
                                'Access-Control-Allow-Origin':'*'
                                }
                        response.end 'updated'

app.post '/delete/:coleccion/:id', (request, response) ->
        db.collection request.params.coleccion, (error, collection) ->
                collection.remove {'_id':new BSON.ObjectID(request.params.id)}, (error, resultado) ->
                        response.writeHead 200, {
                                'Content-Type':'text/plain'
                                'Access-Control-Allow-Origin':'*'
                                }
                        response.end 'deleted'

app.post '/insert/:coleccion', (request, response) ->
        db.collection request.params.coleccion, (error, collection) ->
                object = request.body
                collection.insert object, {safe:true}, (error, resultado) ->
                        response.writeHead 200, {
                                'Content-Type':'text/plain'
                                'Access-Control-Allow-Origin':'*'
                                }
                        response.end object._id.toString()


app.listen 8080









