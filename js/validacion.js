// Comprueba que el sumatorio de los 4 precios introducidos no sea superior a 20€:
function Validar() {

    var p1 = document.getElementById("precioPrimero"); 
    var p2 = document.getElementById("precioSegundo");
    var p3 = document.getElementById("precioPostre");
    var p4 = document.getElementById("precioBebida");

    var total = document.getElementById("sumatorio");
    var calculo = Number(p1.value) + Number(p2.value) + Number(p3.value) + Number(p4.value);
    total.innerHTML = "Precio total: ....... " + calculo + "€";		

    if (calculo > 20) {

        document.getElementById("errorSumatorio").innerHTML = "¡El precio del menú no puede exceder los 20€!";
        return false;	

    } else {

        // alert ("Antes de volver al Submit!");
        return true;

    }

}

// Comprueba que los dos campos contienen la misma contraseña:
function Confirmar() {

    var t1 = document.getElementById("newPassword");
    var t2 = document.getElementById("newPasswordConfirmation");

    if (t1.value != t2.value) {

        document.getElementById("errorDeCambio").innerHTML = "¡Las nuevas contraseñas deben coincidir!";
        return false;

    } else {

        return true;

    }

}

// Comprueba que la fecha de la reserva no sea anterior a hoy:
function Verificar() {

    var fecha = document.getElementById("fecha");
	var fechaM = fecha.value.split('-');
	var f = new Date(fechaM[0] + "-" + fechaM[1] + "-" + fechaM[2]);
    var today = new Date();

    if (f <= today) {

        document.getElementById("errorDeFecha").innerHTML = "¡La fecha debe ser posterior a hoy!";
        return false;
        
    } else {

        return true;

    }
    
}
