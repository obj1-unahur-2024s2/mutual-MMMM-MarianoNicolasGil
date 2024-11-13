class Actividad {
  const property idiomas = []

  method esInteresante() = idiomas.size() > 1
}

class Gimnasia inherits Actividad {
  method initialize() {
    idiomas.clear()
    idiomas.add("espaniol")
  }

  method dias() = 1

  method implicaEsfuerzo() = true

  method sePuedeBroncear() = false
}

class Playa inherits Actividad {
  var largo

  method dias() = largo / 500

  method implicaEsfuerzo() = largo > 1200
  
  method sePuedeBroncear() = true
}

class Ciudad inherits Actividad {
  var atracciones

  method dias() = atracciones / 2

  method implicaEsfuerzo() = atracciones.between(5, 8)

  method sePuedeBroncear() = false

  override method esInteresante() = super() || atracciones == 5
}

class CiudadTropical inherits Ciudad {
  override method dias() = super() + 1

  override method sePuedeBroncear() = true
}

class Trekking inherits Actividad {
  var kilometros
  var diasDeSol

  method dias() = kilometros / 50

  method implicaEsfuerzo() = kilometros >= 80

  method sePuedeBroncear() = self.cumpleCondicionParaBroncear()

  method cumpleCondicionParaBroncear() {
    return diasDeSol > 200 || (diasDeSol.between(100, 200) and kilometros > 120)
  }

  override method esInteresante() = super() and diasDeSol > 140
}





//////////////SOCIOS
class Socio {
  var maximoActividades
  var edad
  const property actividades = []
  const property idiomas = []

  method adoradorDeSol() = actividades.all({ act => act.sePuedeBroncear() })

  method actividadesEsforzadas() = actividades.filter({ act => act.implicaEsfuerzo() })

  method registrarActividad(actividad) {
    if(maximoActividades == actividad.size()) {
      self.error("maximo actividades")
    } else {
      actividades.add(actividad)
    }
  }
}

class Tranquilo inherits Socio {
  method leAtraeActividad(actividad) = actividad.dias() >= 4
}

class Coherent inherits Socio {
  method leAtraeActividad(actividad) = self.adoradorDeSol() and actividad.sePuedeBroncear() || actividad.implicaEsfuerzo()
}

class Relajado inherits Socio {
  method leAtraeActividad(actividad) {
    return not idiomas.intersection(actividad.idiomas()).isEmpty()
  }
}