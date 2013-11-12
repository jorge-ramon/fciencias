// Generated by CoffeeScript 1.6.3
var modelo;

modelo = {
  user: ko.observable(""),
  pass: ko.observable(""),
  inicio_sesion: function() {
    return $.ajax({
      url: "http://localhost:8080/get/usuarios",
      type: 'GET',
      data: {
        query: {
          num_cuenta: modelo.user(),
          pass: modelo.pass()
        }
      },
      dataType: 'jsonp',
      jsonpCallback: 'call_usuarios',
      success: function(data) {
        return console.log(data);
      }
    });
  }
};

ko.applyBindings(modelo);