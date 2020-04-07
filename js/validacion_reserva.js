// Validación datos para formulario de reservas:

function validatePhone() {

    // Obtenemos el teléfono:
    var telefono = document.getElementById("telefono");
    var valido = true;

    // Atributos que debe cumplir el teléfono:
    var isPhone = /^\d{9}$/;

    if (!telefono.isPhone) {

        var error = "El teléfono no es válido";
        valido = false;

    } else {

        var error = "";

    }

    return error;

}
