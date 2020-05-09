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
                <h6> Páginas Públicas (visibles [frontend] para todos) </h6>
            </a>
            
            <br>

            <ul>

                <li> <i> index.php                </i> - Página principal del restaurante con información general.     </li>
                <li> <i> carta.php                </i> - Carta del restaurante (páginada y tabulada) y menú del día.   </li>
                <li> <i> reservas.php             </i> - Formulario de reservas para clientes con validación.          </li>
                <li> <i> ubicacion.php            </i> - Información sobre la ubicación del restaurante.               </li>
                <li> <i> personal.php             </i> - Acceso a la gerencia del restaurante (login).                 </li>
                <li> <i> confirmacion_reserva.php </i> - Detalles de la reserva (solo se llega mediante reservas.php). </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "paginasGerencia">
                <h6> Páginas de Gerencia (visibles [frontend] tras login) </h6>
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
                <h6> Páginas de Gestion (invisibles [backend]) </h6>
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
                <li> <i> desconexion.php                    </i> - Eliminación de la sesión actual (logout)</li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "otrasPaginas">
                <h6> Otras Páginas (insertadas en páginas visibles [frontend]) </h6>
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
                <h6> CSS (hojas de estilo en cascada [backend]) </h6>
            </a>

            <br>

            <ul>

                <li> <i> -- </i> - </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "JS">
                <h6> JavaScript (funciones JS [backend]) </h6>
            </a>

            <br>

            <ul>

                <li> <i> -- </i> - </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "SQL">
                <h6> SQL (base de datos de IISSI 1 [backend]) </h6>
            </a>

            <br>

            <ul>

                <li> <i> IISSI.sql </i> - Base de datos SQL trabajada en IISSI 1. </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

            <a name = "otros">
                <h6> Otros Elementos (imágenes, PDFs, etc.) </h6>
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
                <h6> Funcionalidades (explicación de la web) </h6>
            </a>

            <br>

            <ul>

                <li> </li>
                <li> <i> <a href = "#indice"> Volver al índice </a> </i> </li>

            </ul>

            <br>

        </div>

    </main>

    <br>

    <?php 

        include_once("pie.php");

    ?>

</body>

</html>
