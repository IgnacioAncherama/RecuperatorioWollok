// Primera Parte

class Plato{
	var property peso = 0
	method aptoVegetariano() = true
	method valoracion() = 0
	method esAbundante() = self.peso() > 250
}

class Provoleta inherits Plato{
	var property especias = false
	override method aptoVegetariano() = !especias
	method esEspecial() = self.esAbundante() || especias
	override method valoracion() = if (self.esEspecial()) {120} else {80}
}

class BurgerCarne inherits Plato{
	var tipoPan 
	override method peso() = 250
	override method aptoVegetariano() = false
	override method valoracion() = 60 + tipoPan.valoracion()
}

object panIndustrial{
	method valoracion() = 0
}
object panCasero{
	method valoracion() = 20 
}
object panMasaMadre{
	method valoracion()= 45
}

class BurgerVegetarianas inherits BurgerCarne{
	var hechoDe
	method legumbre(tipo){hechoDe = tipo}
	override method aptoVegetariano() = true
	method valoracionA() = if (hechoDe.size()*2 > 17){17} else {hechoDe.size()*2}
	override method valoracion() = super() + self.valoracionA()
}

class Parrillada inherits Plato{
	const cortes = #{}
	const condicion = 15 * (cortes.max{corte => corte.calidad()}).calidad() - cortes.size()
	override method peso() = cortes.sum{corte => corte.peso()}
	override method aptoVegetariano() = false
	override method valoracion() = if (condicion > 0){condicion} else {self.error("cantidad negativa")}
}

class Cortes{
	var property peso = 0
	var property calidad = 0
	var property nombre = "nombre"
}

// Segunda Parte

class Comenzales{
	var property comidas = []
	var property peso 
	method leAgrada(unaComida) = false
	method comer(unaComida) = comidas.add(unaComida)
	method estaSatisfecho() = comidas.sum{comida => comida.peso()} >= 0.01 * peso
}

class Vegetarianos inherits Comenzales{
	override method leAgrada(unaComida) = unaComida.aptoVegetariano() && unaComida.valoracion() > 85
	override method estaSatisfecho() = super() && !(comidas.any{comida => comida.esAbundante()})
}

class HambrePopular inherits Comenzales{
	override method leAgrada(unaComida) = unaComida.esAbundante()
}

class PaladarFino inherits Comenzales{
	override method leAgrada(unaComida) = unaComida.peso().between(150, 300) && unaComida.valoracion() > 100
	override method estaSatisfecho() = super() && comidas.size().even()
}

//Tercer Parte

class Cocina{
	const comidasEnCarta = #{}
	const comidasVegetarianas = comidasEnCarta.filter{comida => comida.aptoVegetariano()}
	const comidasCarnivoras = comidasEnCarta.filter{comida => !(comida.aptoVegetariano())}
	method tieneBuenaOfertaVegetariana() = comidasCarnivoras.size() - comidasVegetarianas.size() < 2
	method platoFuerteCarnivoro() = comidasCarnivoras.max{comida => comida.valoracion()}
	method comidasQueGustan(comenzal) = comidasEnCarta.filter{comida => comenzal.leAgrada(comida)}
	//También se pide poder elegir un plato para un comensal - por ahora es cualquier plato que le guste. Si no le gusta ningún plato, 
	//lanzar un error. Si el plato existe, sacarlo de la cocina y hacer que el comensal lo coma.
//	method comidaGusta(comenzal) = self.comidasQueGustan(comenzal)
//	method elegirPlato(comenzal) = if ((comidasEnCarta.intersection(self.comidasQueGustan(comenzal))).size() == 0) {self.error("error")} else {}
																		 
}