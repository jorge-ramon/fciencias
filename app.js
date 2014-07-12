var express = require('express');
var body_parser = require('body-parser');
var app = express();

app.use(body_parser.json());
app.use(express.static(__dirname));
app.set('views', __dirname + '/jade');
app.set('view engine','jade');

app.get('/', function(request, response){
    response.render('index');
});

app.listen(8080);
