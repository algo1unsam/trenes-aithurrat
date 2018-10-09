import Formaciones.*
import Vagones.*
import Locomotoras.*

class Deposito {

	var formaciones = []
	var locomotorasSueltas = []

	method agregarFormacion(formacion) {
		formaciones.add(formacion)
	}

	method conjuntoDeVagonesPesados() {
		return formaciones.map{ vagon => vagon.vagonMasPesado() }
	}

	method conductorExperimentado() {
		return formaciones.any{ formacion => formacion.esCompleja() }
	}

	method agregarLocomotoraSuelta(locomotora) {
		locomotorasSueltas.add(locomotora)
	}

	method agregarLocomotoraExtra(formacion) {
		if (!formacion.puedeMoverse()) {
			formacion.locomotoras().add(self.locomotoraAptaParaAgregar(formacion))
		}
	}

	method locomotoraAptaParaAgregar(formacion) {
		return locomotorasSueltas.find{ locomotora => locomotora.arrastreUtil() >= formacion.cuantosKilosDeArrastreLeFalta() }
	}

}

