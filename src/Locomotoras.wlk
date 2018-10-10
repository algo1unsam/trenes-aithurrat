class Locomotora {

	var property peso = 100
	var property arrastreMaximo = 0
	var property velocidadMaxima = 0

	method arrastreUtil() {
		return arrastreMaximo - peso
	}
	
	method velocidadMaxima(nuevaVel){
		velocidadMaxima=nuevaVel
	}

}
