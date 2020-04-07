// Validación datos para formulario de login de personal:

function validateUsername() {

    // Obtenemos el usuario:
    var username = document.getElementById("usuario");
    var valido = true;

    // Atributos que debe cumplir el usuario:
    var isAlphabetical = /^\d{9}$/;

    if (!username.isAlphabetical) {

        var error = "Los datos introducidos no son válidos";
        valido = false;

    } else {

        var error = "";

    }

    return error;

}

function validatePassword() {

    // Obtenemos la contraseña:
    var password = document.getElementById("password");
    var valido = true;

    // Atributos que debe cumplir la contraseña:
    var isAlphabetical = /^\d{9}$/;
    var isNumerical = /^\d{9}$/;

    if (!password.isAlphabetical || !password.isNumerical) {

        var error = "Los datos introducidos no son válidos";
        valido = false;

    } else {

        var error = "";

    }

    return error;

}
