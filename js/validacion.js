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

        document.getElementById("errorSumatorio").innerHTML = "¡El precio no puede exceder los 20€!";
        return false;	

    } else {

        // alert ("Antes de volver al Submit!");
        return true;

    }

}
