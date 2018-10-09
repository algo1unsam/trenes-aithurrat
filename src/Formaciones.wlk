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

}

class TrenCortaDistancia inherits Formacion {

	method estaBienArmado() {
		self.puedeMoverse() && not self.esCompleja()
	}

	method velocidadMaxima() {
		// locomotoras.velocidadMaxima().min(60)
		60
	}

}

class TrenLargaDistancia inherits Formacion {

	const origen = null
	const destino = null

	method estaBienArmado() {
		self.puedeMoverse() && self.tieneSuficientesBanios()
	}

	method tieneSuficientesBanios() {
		self.cantidadDeBanios() >= vagones.cantidadDePasajeros() / 50
	}

	method cantidadDeBanios() = vagones.sum{ vagon => vagon.cantidadDeBanios() }

	method velocidadMaximaLegal() {
		if (origen.esGrande() and destino.esGrande()) 200 else 150
	}

	method velocidadMaxima() {
		return self.velocidadMaximaLocomotoras().min(self.velocidadMaximaLegal())
	}

}

class Ciudad {

	const property esGrande = false

}

