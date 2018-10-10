class VagonDePasajero {

	var property ancho = 0
	var property largo = 0
	var property cantidadBanio = 1

	method cantidadDePasajeros() {
		if (ancho <= 2.5) {
			return largo * 8
		} else return largo * 10
	}

	method pesoMaximo() {
		return self.cantidadDePasajeros() * 80
	}
	
	method cantidadDeBanios(){
		if (self.cantidadDePasajeros()< 50){
			return 1
		}else{
			return self.cantidadDePasajeros()/50
		}
	}

}

class VagonDeCarga {

	var property cargaMaxima = 100

	method pesoMaximo() {
		return cargaMaxima + 160
	}

	method cantidadDeBanios() = 0


method cantidadDePasajeros(){
	return 0
}
}
