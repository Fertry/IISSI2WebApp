## Restaurante Casa Salvi

### Contenidos del Proyecto

>A continuación se describen los contenidos (páginas) y funcionalidades del proyecto 'Restaurante Casa Salvi' de IISSI 2 realizado por Alejandro Fernández Trigo y Jesus Carrero Nuñez del G2 de IC.

#### Índice

1. Páginas Públicas
2. Páginas de Gerencia
3. Páginas de Gestión
4. Otras Páginas
5. CSS
6. JS
7. Otros Elementos
8. Funcionalidades

##### Páginas Públicas (visibles [frontend] para todos)

* index.php - Página principal del restaurante con información general.
* carta.php - Carta del restaurante (páginada y tabulada) y menú del día.
* reservas.php - Formulario de reservas para clientes con validación.
* ubicacion.php - Información sobre la ubicación del restaurante.
* personal.php - Acceso a la gerencia del restaurante (login). 
* confirmacion_reserva.php - Detalles de la reserva (solo se llega mediante reservas.php).
* about.php - Similar a este fichero MD (descripción del proyecto).

##### Páginas de Gerencia (visibles [frontend] tras login)

* area_personal.php - Listado de las reservas recientes (paginado y tabulado) y con controles.
* area_personal_productos.php - Listado de productos (carta) (paginado y tabulado) y con controles.
* area_personal_pass.php - Formulario de cambio de contraseña (validado con JS). 
* insertado_producto.php - Formularios de insertado y actualizado (en BD) de productos de la carta.
* actualizar_menu.php - Formulario de cambio del menú (validado con JS). 

##### Páginas de Gestión (invisibles [backend])

* validacion_formulario_cambio.php - Validación en servidor del cambio de contraseña.   
* validacion_formulario_personal.php - Validación en servidor del login de personal.php
* validacion_formulario_reserva.php - Validación en servidor del formulario de reserva.php
* paginacion_consulta.php - Funciones para paginar resultados de consultas.   
* modificacion_menu.php - Validación del cambio de productos/precio del menú.
* gestionBD.php - Funciones de conexión con la BD de Oracle.
* gestion_reserva.php - Validacion y procesado del formulario de reservas. 
* gestion_productos_insertar.php - Validación del formulario de insertado de productos.  
* gestion_productos_eliminar.php - Validación y procesado del formulario de eliminación. 
* gestion_productos_actualizar.php - Validación del insertado de nuevos productos.
* desconexion.php - Eliminación de la sesión actual (logout).

##### Otras Páginas (insertadas en páginas visibles [frontend])

* navegacion.php - Menú de botones de navegación para moverse a otras páginas. 
* navegacion_personal.php - Similar a navegación pero para las páginas de gerencia.
* pie.php - Pie de página con enlaces a sitios relevantes.
* header_index.php - Cabecera de index.php.
* header_carta.php - Cabecera de carta.php.    
* header_reservas.php - Cabecera de reservas.php.
* header_ubicacion.php - Cabecera de ubicacion.php.
* header_personal.php - Cabecera de personal.php y demás páginas de gerencia.

##### CSS (hojas de estilo en cascada [backend])

* css/aboutCSS.css - Hoja de estilos de about.php
* css/carta2.css - Hoja de estilos de carta.php 
* css/confirmacionReserva.css - Hoja de estilos de confirmacion_reserva.php
* css/gestionReservas.css - Hoja de estilos de area_personal.php
* css/index.css - Hoja de estilos de index.php  
* css/listadoProductos.css - Hoja de estilos de area_personal_productos.php
* css/personalPassCSS.css - Hoja de estilos de area_personal_pass.php    
* css/personalProductoCSS.css - Hoja de estilos de area_personal_productos.php
* css/personalProvisional2.css - Hoja de estilos de area_personal.php   
* css/reservaCSS.css - Hoja de estilos de reservas.php 
* css/actualizacionMenu.css - Hoja de estilos de actualizar_menu.php
* css/ubicacion.css - Hoja de estilos de ubicacion.php 

##### JavaScript (funciones JS [backend])

* js/validacion.js - Validación JS de la contraseña y de la modificación del menú.

##### SQL (base de datos de IISSI 1 [backend])

* sql/IISSI (Código completo).sql - Base de datos SQL trabajada en IISSI 1.
* 0. Borrado de tablas.sql - Borrado de tablas.
* 1. Creacion de tablas.sql - Creación de tablas.
* 2. Secuencias, triggers y procedimientos.sql - Secuencias, triggers y procedimientos de insertado y actualizado.
* 3. Carga de datos.sql - Datos de prueba.

##### Otros Elementos (imágenes, PDFs, etc.)

* /images (carpeta) - Carpeta que contiene todas las imágenes del proyecto.
* documents/IC-G2 Restaurante Casa Salvi - Mockup.pdf - PDF del 2º entregable (Mockup del proyecto).
* documents/Documento de Evidencias IISSI 2 - Restaurante Casa Salvi.pdf
* /.git - Carpeta (oculta por defecto en sistemas Windows) de GitHub (control de versiones).
* README.md - Este mismo fichero.

##### Funcionalidades (explicación de la aplicación web)

Para realizar este proyecto nos hemos puesto en contacto con el propietario de un restaurante
situado en Gerena (Sevilla), el cual quiere mejorar la gestión de su negocio.

Para dar solución a los problemas hemos desarrollado una aplicación web que permita por una parte, realizar reservas de forma telemática a los clientes y, por otra parte, gestionar esas reservas al restaurante. Así mismo, la aplicación permite a los clientes consultar en todo momento la carta y menú del día; mientras que el restaurante gana la capacidad de modificar dichos datos en tiempo real (añadir, eliminar y modificar productos y el menú del día). 

La aplicación puede dividirse en páginas visibles (aquellas que puede ver cualquiera), páginas visibles solo tras login (aquellas que precisan autenticación para verse) y por último, páginas 'ocultas' que se encargan de la gestión de las consultas, modificaciones, validaciones, etc...

En el conjunto de las páginas visibles esta la página principal (index) que proporciona información general sobre la misión del restaurante, su horario y un método de contacto telefónico. Todas las páginas disponen de un menú de navegación (botonera) para moverse por las demás páginas.Las páginas de ubicación y carta proporcionan información específica sobre la localización del restaurante y la comida que sirve (junto con su precio). 

La página de reservas cuenta con un formulario que recoge: Nombre, Apellidos, Edad, Teléfono, Nº de personas y Fecha de la reserva. Todos los datos son validados en el momento en cliente (mediante HTML 5) y una vez enviados son validados en servidor (con PHP y consultas a la BD). Se comprueba que tanto los nombres como los apellidos sean de caracter alfabéticos, así cómo la edad debe ser superior a los 18 años y el teléfono debe ser válido. También se valida que el nº de comensales no exceda la capacidad de las mesas y que existan mesas disponibles para la reserva en la fecha solicitada. Asociado a la página de reservas existe una página de confirmación de reservas a la que solo se llega tras rellenar el formulario de reserva y ser este correctamente validado; esta página muestra la información de la reserva realizada al cliente y dispone de un botón para volver al inicio.

En el conjunto de las páginas visibles tras iniciar sesión, para llegar a ellas hay que pasar de forma obligatoria por la página de personal que cuenta con un login (acceso vía credenciales) para el personal administrador (gerente del restaurante). Solo trás haberse autentificado correctamente (el formulario también se valida en cliente y en servidor) se puede acceder al área de gerencia que cuenta con: 

* Gestión de las Reservas: una consulta paginada y tabulada que muestre las reservas realizadas con sus detalles y dispone de un control para su anulación si fuera necesario.
* Listado de productos: una consulta paginada y tabulada que muestre todos los productos de la carta junto con su precio y un control para eliminarlos.
* Gestión de personal: formulario que permite cambiar la contraseña previa validación (en cliente y servidor junto con JavaScript) de que es una contraseña válida.
* Gestión de productos: formularios que permiten insertar nuevos productos y/o modificar el precio de productos ya existentes. Todo ello validado en cliente y servidor de forma que no pueden introducirse nombres no válidos, precios negativos, etc...
* Gestión de menú: área que muestre el menú actual (igual que en carta) y cuenta a su vez con un formulario de cambio para modificar el menú del día. Este formulario recoge los nombres y precios de los nuevos platos a incluir en el menú y está validado (en cliente y servidor) junto con JavaScript para impedir que el sumatorio de los cuatro precios sean mayores en ningún caso a 20€. 
  
En todas las páginas de gerencia se añade además un menú de navegación adicional para moverse por las páginas de gerencia así como un botón que permite cerrar la sesión en cualquier momento.

> Proyecto IISSI 2 - G2 IC - Universidad de Sevilla
