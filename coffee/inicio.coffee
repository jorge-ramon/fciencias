modelo = {
	user: ko.observable ""
	pass: ko.observable "" 
	inicio_sesion: ->
		$.ajax {
			url: "http://localhost:8080/get/usuarios"
			type: 'GET'
			data: { query: {num_cuenta: modelo.user(), pass: modelo.pass()} }
			dataType: 'jsonp'
			jsonpCallback: 'call_usuarios'
			success:(data) ->
				console.log data
			}
	}

ko.applyBindings modelo
