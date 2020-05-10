<!DOCTYPE html>

<html lang="es">

<head>

    <!-- Cabecera -->
	<meta charset="UTF-8">
	<meta name="author" content="Casa Salvi">
    <link rel="icon" href="images/icono.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/about.css"/>
	<meta name="classification" content="Restaurante">
	<meta name="description" content="About">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, about, informacion">

	<title>About</title>
    
</head>

<body>

    <?php 

        include_once("header_index.php");

    ?>

    <?php 

        include_once("navegacion.php");

    ?>
    <br>

    <main>

        <div class = "about">

            <h2> <b> Contenidos del Proyecto </b> </h2>

            <br>

            <p> A continuación se describen los contenidos (páginas) y funcionalidades del proyecto <i>'Restaurante Casa Salvi'</i>
            de IISSI 2 realizado por Alejandro Fernández Trigo y Jesus Carrero Nuñez del G2 de IC. </p>

            <br><br>

            <a name = "indice">
                <h4> <b> índice </b> </h4>
            </a>

            <ol>

                <a href = "#paginasPublicas">
                    <li> Páginas Públicas     </li>
                </a>
                <a href = "#paginasGerencia">
                    <li> Páginas de Gerencia  </li>
                </a>
                <a href = "#paginasGestion">
                    <li> Páginas de Gestión   </li>
                </a>
                <a href = "#otrasPaginas">
                    <li> Otras Páginas        </li>
                </a>
                <a href = "#CSS">
                    <li> CSS                  </li>
                </a>
                <a href = "#JS">
                    <li> JS                   </li>
                </a>
                <a href = "#otros">
                    <li> Otros Elementos      </li>
                </a>
                <a href = "#funcionalidades">
                    <li> Funcionalidades      </li>
                </a>

            </ol>

            <br><br>

            <a name = "paginasPublicas">
                <h5> Páginas Públicas (visibles [frontend] para todos) </h5>
            </a>
            
            <br>

            <ul>

                <li> <i> index.php                </i> - Página principal del restaurante con información general.     </li>
                <li> <i> carta.php                </i> - Carta del restaurante (páginada y tabulada) y menú del día.   </li>
                <li> <i> reservas.php             </i> - Formulario de reservas para clientes con validación.          </li>
                <li> <i> ubicacion.php            </i> - Información sobre la ubicación del restaurante.               </li>
                <li> <i> personal.php             </i> - Acceso a la gerencia del restaurante (login).                 </li>
                <li> <i> confirmacion_reserva.php </i> - Detalles de la reserva (solo se llega mediante reservas.php). </li>
                <li> <i> about.php                </i> - Este mismo fichero.                                           </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "paginasGerencia">
                <h5> Páginas de Gerencia (visibles [frontend] tras login) </h5>
            </a>

            <br>

            <ul> 

                <li> <i> area_personal.php           </i> - Listado de las reservas recientes (paginado y tabulado) y con controles. </li>
                <li> <i> area_personal_productos.php </i> - Listado de productos (carta) (paginado y tabulado) y con controles.      </li>
                <li> <i> area_personal_pass.php      </i> - Formulario de cambio de contraseña (validado con JS).                    </li>
                <li> <i> insertado_producto.php      </i> - Formularios de insertado y actualizado (en BD) de productos de la carta. </li>
                <li> <i> actualizar_menu.php         </i> - Formulario de cambio del menú (validado con JS).                         </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "paginasGestion">
                <h5> Páginas de Gestion (invisibles [backend]) </h5>
            </a>

            <br>

            <ul>

                <li> <i> validacion_formulario_cambio.php   </i> - Validación en servidor del cambio de contraseña.      </li>
                <li> <i> validacion_formulario_personal.php </i> - Validación en servidor del login de personal.php      </li>
                <li> <i> validacion_formulario_reserva.php  </i> - Validación en servidor del formulario de reserva.php  </li>
                <li> <i> paginacion_consulta.php            </i> - Funciones para paginar resultados de consultas.       </li>
                <li> <i> modificacion_menu.php              </i> - Validación del cambio de productos/precio del menú.   </li>
                <li> <i> gestionBD.php                      </i> - Funciones de conexión con la BD de Oracle.            </li>
                <li> <i> gestion_reserva.php                </i> - Validacion y procesado del formulario de reservas.    </li>
                <li> <i> gestion_productos_insertar.php     </i> - Validación del formulario de insertado de productos.  </li>
                <li> <i> gestion_productos_eliminar.php     </i> - Validación y procesado del formulario de eliminación. </li>
                <li> <i> gestion_productos_actualizar.php   </i> - Validación del insertado de nuevos productos.         </li>
                <li> <i> desconexion.php                    </i> - Eliminación de la sesión actual (logout).             </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "otrasPaginas">
                <h5> Otras Páginas (insertadas en páginas visibles [frontend]) </h5>
            </a>

            <br>

            <ul>

                <li> <i> navegacion.php          </i> - Menú de botones de navegación para moverse a otras páginas. </li>
                <li> <i> navegacion_personal.php </i> - Similar a navegación pero para las páginas de gerencia.     </li>
                <li> <i> pie.php                 </i> - Pie de página con enlaces a sitios relevantes.              </li>
                <li> <i> header_index.php        </i> - Cabecera de index.php.                                      </li>
                <li> <i> header_carta.php        </i> - Cabecera de carta.php.                                      </li>
                <li> <i> header_reservas.php     </i> - Cabecera de reservas.php.                                   </li>
                <li> <i> header_ubicacion.php    </i> - Cabecera de ubicacion.php.                                  </li>
                <li> <i> header_personal.php     </i> - Cabecera de personal.php y demás páginas de gerencia.       </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "CSS">
                <h5> CSS (hojas de estilo en cascada [backend]) </h5>
            </a>

            <br>

            <ul>

                <li> <i> css/about.css                </i> - Hoja de estilos de about.php                       </li>
                <li> <i> css/carta2.css               </i> - Hoja de estilos de carta.php                       </li>
                <li> <i> css/confirmacionReserva.css  </i> - Hoja de estilos de confirmacion_reserva.php        </li>
                <li> <i> css/gestionReservas.css      </i> - Hoja de estilos de area_personal.php               </li>
                <li> <i> css/index.css                </i> - Hoja de estilos de index.php                       </li>
                <li> <i> css/listadoProductos.css     </i> - Hoja de estilos de area_personal_productos.php     </li>
                <li> <i> css/personalPass.css         </i> - Hoja de estilos de area_personal_pass.php          </li>
                <li> <i> css/personalProducto.css     </i> - Hoja de estilos de area_personal_productos.php     </li>
                <li> <i> css/personalProvisional2.css </i> - Hoja de estilos de area_personal.php               </li>
                <li> <i> css/reserva.css              </i> - Hoja de estilos de reservas.php                    </li>
                <li> <i> css/restaurante.css          </i> - Hoja de estilos genérica del restaurante           </li>
                <li> <i> css/ubicacion.css            </i> - Hoja de estilos de ubicacion.php                   </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "JS">
                <h5> JavaScript (funciones JS [backend]) </h5>
            </a>

            <br>

            <ul>

                <li> <i> js/validacion.js </i> - Validación JS de la contraseña y de la modificación del menú. </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "SQL">
                <h5> SQL (base de datos de IISSI 1 [backend]) </h5>
            </a>

            <br>

            <ul>

                <li> <i> sql/IISSI.sql </i> - Base de datos SQL trabajada en IISSI 1. </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "otros">
                <h5> Otros Elementos (imágenes, PDFs, etc.) </h5>
            </a>

            <br>

            <ul>

                <li> <i> /images (carpeta)                         </i> - Carpeta que contiene todas las imágenes del proyecto.   </li>
                <li> <i> IC-G2 Restaurante Casa Salvi - Mockup.pdf </i> - PDF del 2º entregable (Mockup del proyecto).            </li>
                <li> <i> README.md                                 </i> - Fichero similar a about.php pero en formato 'Markdown'. </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "funcionalidades">
                <h5> Funcionalidades (explicación de la aplicación web) </h5>
            </a>

            <br>

            <p>

            Para realizar este proyecto nos hemos puesto en contacto con el propietario de un restaurante
            situado en Miguel de Cervantes, 46, 41860 (Gerena-Sevilla), el cual quiere mejorar la gestión
            de su negocio.

            <br><br>

            Para dar solución a los problemas hemos desarrollado una aplicación web que permita por una parte, 
            realizar reservas de forma telemática a los clientes y, por otra parte, gestionar esas reservas al 
            restaurante. Así mismo, la aplicación permite a los clientes consultar en todo momento la carta y 
            menú del día; mientras que el restaurante gana la capacidad de modificar dichos datos en tiempo real
            (añadir, eliminar y modificar productos y el menú del día). 

            <br><br>

            La aplicación puede dividirse en páginas visibles (aquellas que puede ver cualquiera), páginas visibles
            solo tras login (aquellas que precisan autenticación para verse) y por último, páginas 'ocultas' que
            se encargan de la gestión de las consultas, modificaciones, validaciones, etc...
 
            <br><br>

            En el conjunto de las páginas visibles esta la página principal (index) que proporciona información
            general sobre la misión del restaurante, su horario y un método de contacto telefónico. Todas las páginas
            disponen de un menú de navegación (botonera) para moverse por las demás páginas.Las páginas de ubicación 
            y carta proporcionan información específica sobre la localización del restaurante y la comida que sirve 
            (junto con su precio). 

            <br><br>

            La página de reservas cuenta con un formulario que recoge: Nombre, Apellidos, Edad, Teléfono, Nº de personas 
            y Fecha de la reserva. Todos los datos son validados en el momento en cliente (mediante HTML 5) y una vez 
            enviados son validados en servidor (con PHP y consultas a la BD). Se comprueba que tanto los nombres como los 
            apellidos sean de caracter alfabéticos, así cómo la edad debe ser superior a los 18 años y el teléfono debe ser
            válido. También se valida que el nº de comensales no exceda la capacidad de las mesas y que existan mesas disponibles
            para la reserva en la fecha solicitada. Asociado a la página de reservas existe una página de confirmación de reservas
            a la que solo se llega tras rellenar el formulario de reserva y ser este correctamente validado; esta página muestra
            la información de la reserva realizada al cliente y dispone de un botón para volver al inicio.

            <br><br>

            En el conjunto de las páginas visibles tras iniciar sesión, para llegar a ellas hay que pasar de forma obligatoria 
            por la página de personal que cuenta con un login (acceso vía credenciales) para el personal administrador (gerente del
            restaurante). Solo trás haberse autentificado correctamente (el formulario también se valida en cliente y en servidor)
            se puede acceder al área de gerencia que cuenta con: 

            <ol>

                <li>
                Gestión de las Reservas: una consulta paginada y tabulada que muestre las reservas realizadas con sus detalles y
                dispone de un control para su anulación si fuera necesario.
                </li>

                <li>
                Listado de productos: una consulta paginada y tabulada que muestre todos los productos de la carta junto con su
                precio y un control para eliminarlos.
                </li>

                <li>
                Gestión de personal: formulario que permite cambiar la contraseña previa validación (en cliente y servidor junto
                con JavaScript) de que es una contraseña válida.
                </li>

                <li>
                Gestión de productos: formularios que permiten insertar nuevos productos y/o modificar el precio de productos ya
                existentes. Todo ello validado en cliente y servidor de forma que no pueden introducirse nombres no válidos, precios
                negativos, etc...
                </li>

                <li>
                Gestión de menú: área que muestre el menú actual (igual que en carta) y cuenta a su vez con un formulario de cambio 
                para modificar el menú del día. Este formulario recoge los nombres y precios de los nuevos platos a incluir en el menú
                y está validado (en cliente y servidor) junto con JavaScript para impedir que el sumatorio de los cuatro precios sean
                mayores en ningún caso a 20€. 
                </li>

            </ol>

            En todas las páginas de gerencia se añade además un menú de navegación adicional para moverse por las páginas de gerencia
            así como un botón que permite cerrar la sesión en cualquier momento.
            </p>

            <p> <i> <a href = "#indice"> Volver al índice </a> </i> </p>

            <br>

        </div>

    </main>

    <br>

    <?php 

        include_once("pie.php");

    ?>

</body>

</html>
