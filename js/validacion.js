function validateForm() {

    var noValidation = document.getElementById("#modificarMenu").novalidate;
    
    if (!noValidation) {

        // Comprobar que el precio del menú no excede los 20€:
        var error1 = validacionPrecio();

        return (error1.length==0) ;

    } else {

        return true;

    }
        
}

function validacionPrecio {

    var precioPrimerPlato = document.getElementById("precioPrimero");
    var precioSegundoPlato = document.getElementById("precioSegundo");
    var precioPostre = document.getElementById("precioPostre");
    var precioBebida = document.getElementById("precioBebida");

    var valido = true;

    // Comprobar el sumatorio de los 4 precios:
    // No debe exceder 20€:
    var sumatorio = precioPrimerPlato + precioSegundoPlato + precioPostre + precioBebida;

    if (sumatorio > 20) {

        valido = false;

    }

    if (!valido) {

        var error = "El precio no puede exceder los 20€";

    } else {

        var error = "";

    }

    return error;
    
}