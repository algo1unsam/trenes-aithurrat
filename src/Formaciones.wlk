import Vagones.*
import Locomotoras.*
import Deposito.*

class Formacion {

	var property locomotoras = []
	var property vagones = []

	method agregarVagon(vagon) {
		vagones.add(vagon)
	}

	method agregarLocomotora(locomotora) {
		locomotoras.add(locomotora)
	}

	method velocidadMaximaLocomotoras() {
		return locomotoras.min{ locomotora => locomotora.velocidadMaxima() }.velocidadMaxima()
	}

	method cantidadVagonesLivianos() {
		return vagones.count({ vagon => vagon.pesoMaximo() < 2500 })
	}

	method sumaPesoMaximoVagones() {
		return vagones.sum{ vagon => vagon.pesoMaximo() }
	}

	method vagonMasPesado() {
		return vagones.max{ vagon => vagon.pesoMaximo() }
	}

	method sumaArrastre() {
		return locomotoras.sum{ locomotora => locomotora.arrastreUtil() }
	}

	method puedeMoverse() {
		return self.sumaArrastre() > self.sumaPesoMaximoVagones()
	}

	method sumaPesoMaximoLocomotoras() {
		return locomotoras.sum{ locomotora => locomotora.peso() }
	}

	method esEficiente() {
		return locomotoras.all{ locomotora => locomotora.arrastreUtil() >= locomotora.peso() * 5 }
	}

	method cuantosKilosDeArrastreLeFalta() {
		return self.sumaPesoMaximoVagones() - self.sumaArrastre()
	}

	method esCompleja() {
		return (locomotoras.size() + vagones.size()) > 20 or (self.sumaPesoMaximoLocomotoras() + self.sumaPesoMaximoVagones()) > 10000
	}

	method cantidadDePasajeros() {
		return vagones.sum{ vagon => vagon.cantidadDePasajeros() }
	}

}

class TrenCortaDistancia inherits Formacion {

	method estaBienArmado() {
		return self.puedeMoverse() && not self.esCompleja()
	}

	method velocidadMaximaLegal() {
		return 60
	}

	method velocidadMaxima() {
		return self.velocidadMaximaLocomotoras().min(self.velocidadMaximaLegal())
	}

}

class TrenLargaDistancia inherits Formacion {

	var origen = null
	var destino = null

	method estaBienArmado() {
		return self.puedeMoverse() && self.tieneSuficientesBanios()
	}

	method tieneSuficientesBanios() {
		return self.cantidadDeBanios() >= self.cantidadDePasajeros() / 50
	}

	method cantidadDeBanios() {
		return vagones.sum{ vagon => vagon.cantidadDeBanios() }
	}

	method velocidadMaximaLegal() {
		if (origen.esGrande() && destino.esGrande()) {
			return 200
		} else {
			return 150
		}
	}

	method velocidadMaxima() {
		return self.velocidadMaximaLocomotoras().min(self.velocidadMaximaLegal())
	}

	method cambiarOrigen(ciudad) {
		origen = ciudad
	}

	method cambiarDestino(ciudad) {
		destino = ciudad
	}

}

class Ciudad {

	var property esGrande = false

}

class TrenesAltaVelocidad inherits Formacion {

	method estaBienArmado() {
		return  self.velocidadMaxima() >= 250 && vagones.all({ vagon => vagon.pesoMaximo() < 2500 })
	}

	method velocidadMaxima() {
		return self.velocidadMaximaLocomotoras().min(self.velocidadMaximaLegal())
	}
	method velocidadMaximaLegal(){
		return 400
	}

}

