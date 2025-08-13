CLASS zcl_tablas_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_tablas_jpfb IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

***    TYPES: BEGIN OF ty_persona, "crear un tipo para la estructura
***            nombre TYPE string,
***            edad TYPE i,
***          END OF ty_persona.
***
***          TYPES: Ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY. "crea un tipo para la tabla
***
***DATA: lt_personas type ty_tabla_personas, "crea la tabla asignándoles un tipo
***      ls_persona type ty_persona. "crea la estructura asignandole un tipo
**
***      ls_persona-nombre = 'Carlos'.
***      ls_persona-edad = 40.
***
***INSERT ls_persona into Lt_personas INDEX 1. "inserta lo que tengas en la estructura en esta tabla, en la fila 1.
***
***       ls_persona-nombre = 'Maria'. "damos otra vez valores a la estructura
***      ls_persona-edad = 30.
***
***INSERT ls_persona into Lt_personas INDEX 2. "insertamos en la línea 2
***"etc
***
***LOOP AT lt_personas into ls_persona. "bucle para imprimir todas las líneas
***out->write( |Nombre: { ls_persona-nombre }, edad { ls_persona-edad } | ).
***
***ENDLOOP.
**
***out->write( lt_personas ). "fuera del loop lo presenta en columnas
**
**    "INSERT VALUE
**
***DATA lt_aeropuerto type STANDARD TABLE OF /dmo/airport.
***insert value #(
***client = 100
***airport_id = 'FRA'
***name = 'Frankfurt Airport'
***city = 'Frankfurt/Main'
***country = 'DE'
***) INTO TABLE lt_aeropuerto.
***
***out->write( lt_aeropuerto ).
**
**
**    "Si queremos enviarlo a una posición en concreto INTO lt_aeropuerto index 1
**
**    "para poner una línea en blanco
**
***insert initial line into table lt_aeropuerto.
***
***"para igualar dos tablas internas usamos el like
***
***DATA lt_aeropuerto2 like Lt_aeropuerto. " la tabla aeropuerto 2 será igual a la lt_aeropuerto
*** "(no copia los datos de los campos)
***
***"duplicar el contenido
***
****insert lines of lt_aeropuerto into table lt_aeropuerto2.
***
****insert lines of lt_aeropuerto to 2 into table lt_aeropuerto2. "hasta el segundo registro
***
***insert lines of lt_aeropuerto from 2 to 3 into table lt_aeropuerto2. "del segundo al tercero
***
***out->write( data = lt_aeropuerto name = 'Lt_aeropuerto2' ).
***
***
***"añadir registros con APPEND (sólo funciona en tablas standard)
***
***    TYPES: BEGIN OF ty_persona, "crear un tipo para la estructura
***             nombre TYPE string,
***             edad   TYPE i,
***           END OF ty_persona.
**
**
**
**DATA: lt_persona TYPE ty_tabla_personas,
**ls_persona TYPE ty_persona.
**
**ls_perspna-nombre = 'Saniel'.
**ls_persona-edad = '23'.
**
**APPEND ls_persona   TO lt_personas.
**
**out->write(  lt_personas ).
**
**
**
**
*******EJERCICIO
***Una biblioteca quiere guardar información sobre los libros que tiene. Para ello, crea un programa que:
***Defina un tipo de estructura ty_libro con estos campos:
***Título (tipo string)
***Autor (tipo string)
***Número de páginas (tipo i)
***Declare una tabla interna lt_libros y una variable ls_libro de ese tipo.
***Añada tres libros usando INSERT ... INDEX para colocarlos en posiciones concretas.
***Recorra la tabla con un LOOP AT  muestre:
***"Libro corto: <título>" si tiene menos de 150 páginas
***"Libro largo: <título>" si tiene más de 500 páginas
***"Libro estándar: <título>" en otro caso
***Finalmente, muestra toda la tabla con out->write.
**
**
**    TYPES:BEGIN OF ty_libro,
**            titulo            TYPE string,
**            autor             TYPE string,
**            numero_de_paginas TYPE i,
**
**          END OF ty_libro.
**
**
**    TYPES: Ty_tabla_libros TYPE STANDARD TABLE OF ty_libro WITH EMPTY KEY.
**
**    DATA: lt_libros TYPE ty_tabla_libros, "crea tabla
**          ls_libro  TYPE ty_libro.
**
**
**
**    ls_libro = VALUE #( titulo = 'El Quijote' autor =  'Cervantes' numero_de_paginas = 2000 ).
**
**    INSERT ls_libro INTO Lt_libros INDEX 1.
**
**
**    ls_libro = VALUE #( titulo = 'Aprender Toki Pona' autor =  'Sonia Kisa' numero_de_paginas = 90 ).
**
**    INSERT ls_libro INTO Lt_libros INDEX 2.
**
**    ls_libro = VALUE #( titulo = 'SAP para Dummies' autor =  'Pepe López' numero_de_paginas = 300 ).
**
**    INSERT ls_libro INTO Lt_libros INDEX 3.
**
**
**    LOOP AT lt_libros INTO ls_libro.
**      IF Ls_libro-numero_de_paginas < 150.
**        out->write( |libro corto: { ls_libro-titulo } | ).
**
**      ELSEIF Ls_libro-numero_de_paginas  > 500.
**        out->write( |libro largo: { ls_libro-titulo } | ).
**
**      ELSE.
**        out->write( |libro estándar: { ls_libro-titulo } | ).
**
**      ENDIF.
**
**    ENDLOOP.
**
**    out->write( |\n| ).
**    out->write( |\n| ).
**
**    out->write( data = lt_libros  name = 'Catalogo completo de libros' ).
**
**
**"Solución profe
***     " 1. Definimos un tipo de estructura para guardar los datos de los libros
***    TYPES: BEGIN OF ty_libro,
***             titulo   TYPE string,
***             autor    TYPE string,
***             paginas  TYPE i,
***           END OF ty_libro.
***
***    " 2. Declaramos una tabla interna y una estructura temporal
***    TYPES: ty_tabla_libros TYPE STANDARD TABLE OF ty_libro WITH EMPTY KEY.
***
***    DATA: lt_libros TYPE ty_tabla_libros,
***          ls_libro  TYPE ty_libro.
***
***    " 3. Insertamos tres libros en posiciones específicas
***    ls_libro = VALUE #( titulo = 'El principito' autor = 'Antoine de Saint-Exupéry' paginas = 96 ).
***    INSERT ls_libro INTO lt_libros INDEX 1.
***
***    ls_libro = VALUE #( titulo = 'Don Quijote' autor = 'Miguel de Cervantes' paginas = 863 ).
***    INSERT ls_libro INTO lt_libros INDEX 2.
***
***    ls_libro = VALUE #( titulo = 'Cien años de soledad' autor = 'Gabriel García Márquez' paginas = 417 ).
***    INSERT ls_libro INTO lt_libros INDEX 2. "Se insertará en el medio
***
***    " 4. Recorremos la tabla y analizamos la longitud de cada libro
***    LOOP AT lt_libros INTO ls_libro.
***
***      IF ls_libro-paginas < 150.
***        out->write( |Libro corto: { ls_libro-titulo }| ).
***
***      ELSEIF ls_libro-paginas > 500.
***        out->write( |Libro largo: { ls_libro-titulo }| ).
***
***      ELSE.
***        out->write( |Libro estándar: { ls_libro-titulo }| ).
***      ENDIF.
***
***    ENDLOOP.
***
***    " 5. Mostramos la tabla completa
***    out->write( data = lt_libros name = 'Catálogo completo de libros' ).
***
**
*****************
**
**"AÑADIR REGISTROS CON EL APPEND
**    "Añade un registro al final de la tabla interna, solo se usa en las standard. hace los mismo que los inserte, mejor usar los insert.
**
***    TYPES: BEGIN OF ty_persona,
***             nombre TYPE string,
***             edad   TYPE i,
***           END OF ty_persona.
***
***  TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
****
***    DATA: lt_personas TYPE ty_tabla_personas,
***          ls_persona  TYPE ty_persona.
****
***
***
***    ls_persona-nombre = 'Daniel'.
***    ls_persona-edad  = '23'.
***
***
***
***    APPEND ls_persona TO lt_personas.
***
***    out->write( lt_personas ).
**
**    """ declaracion lineal del append
**
***    TYPES: BEGIN OF ty_persona,
***             nombre TYPE string,
***             edad   TYPE i,
***           END OF ty_persona.
***
*** TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
***
***    DATA: lt_personas TYPE ty_tabla_personas.
***
***APPEND VALUE #(
***
***        nombre = 'Daniel'
***        edad   = 15
***
*** ) to lt_personas.
**
**    """"""
**    "copiar contenido de unta tabla a otra
**
**
**
**APPEND LINES OF lt_personas TO lt_personas2.
**
**    APPEND LINES OF lt_personas TO 2 TO  lt_personas2.
**
**    APPEND LINES OF lt_personas FROM 4 TO 6 TO  lt_personas2.
**
**
**    "AÑADIR REGISTROS CON EL VALUE
***    no necesitas declarar previamente una estructura aunque sí los tipos,
***a menos que venga impuesto por una tabla externa.
**
***    TYPES: BEGIN OF ty_persona,
***             nombre TYPE string,
***             edad   TYPE i,
***           END OF ty_persona.
***
***    TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
***
***
***    DATA(lt_persona) = VALUE ty_tabla_personas(
***    ( nombre = 'Ana' edad = 25 )
***    ( nombre = 'Javier' edad = 45 )
***    ( nombre = 'Lucia' edad = 22 )
***
***
***    ).
***
***    out->write( lt_persona ).
***
***    DATA ls_persona TYPE ty_persona.
***
***    LOOP AT lt_persona INTO ls_persona.
***
***      out->write( |Nombre: { ls_persona-nombre }, Edad: { ls_persona-edad }| ).
***
***    ENDLOOP.
**
**"extraemos todo de la base de datos / la tabla externa
**data lt_aeropuerto type STANDARD TABLE OF /dmo/airport.
**
**lt_aeropuerto = value #(
**
**        (
**        client = 100
**        airport_id = 'FRA'
**        name = 'Frankfurt Airport'
**        city = 'Frankfurt/Main'
**        country = 'DE'
**        )
**
**                (
**        client = 100
**        airport_id = 'RRA'
**        name = 'Frankfurt Airport'
**        city = 'Frankfurt/Main'
**        country = 'RE'
**        )
**).
**
**out->write( lt_aeropuerto ).
**
****************************************
***Read table con índice
**
***SELECT from /dmo/airport
***FIELDS *
***where country = 'DE' "selecciona todos los campos donde country es DE
***into table @DATA(lt_flights). "guarda el resultado de a consulta en una nueva tabla . en ABAP clásico la tabla se debe crear manualmente,
***"pero en Cloud se hace así diréctamente.
***
***if sy-subrc = 0. "si es distinto a 0 cuando hay una excepción técnica. si no ha encontrado registros es 4.
***out->write( lt_flights ).
***
***READ table lt_flights into data(ls_flights) index 4. "lee una línea de la tabla y lo almacenamos en una estructura (creada implícitamente en línea)
***endif.
***out->write( data = lt_flights name = 'tabla de vuelos' ).
***out->write( data = ls_flights name = 'estructura de vuelos' ).
***
***READ table lt_flights into data(ls_flights2) index 4 TRANSPORTING airport_id city.
***"se lleva los campos airport_id y city a la nueva estructura ls_flights2
***out->write( data = ls_flights2 name = 'Estructura vuelos' ).
***
***endif.
**
**"field symbol
**
**SELECT from /dmo/airport
**FIELDS *
**where country = 'DE' "selecciona todos los campos donde country es DE
**into table @DATA(lt_flights). "guarda el resultado de a consulta en una nueva tabla . en ABAP clásico la tabla se debe crear manualmente,
**"pero en Cloud se hace así diréctamente.
**
**if sy-subrc = 0. "si es distinto a 0 cuando hay una excepción técnica. si no ha encontrado registros es 4.
**out->write( lt_flights ).
**
**READ table lt_flights ASSIGNING FIELD-SYMBOL(<lsf_flight>) index 3.
**out->write( data = <lsf_flight> name = `<lfs_flight>)` ).
**
**"forma moderna de usar read table con índice
**
**DATA(ls_data) = lt_fligths[ 2 ].
**out->write( data = ls_data name = 'ls_data' ).
**DATA(ls_data2) = value #( lt_fligths[ 28 ] default lt_flights[ 1 ] ).
**"si no me encuentra la línea 28, muestra la 1. hay que poner value # si se utiliza el default
**
**endif.
**
**"read table con clave
**
**IF  sy-subrc = 0.
**
**READ TABLE Ll_flights into data(ls_flight) WITH KEY city = 'Berlín'.
**out->write( data = lt_flights name 'lt_flights' ).
**out->write( data = lt_flights name 'ls_flight' ).
**
**Endif.
**
**
**"forma moderna de leer tabla con clave
**
**
***DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ].
***out->write( data = ls_flight2 name = `ls_flight2` ).
**
**"""
**DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ]-name.
**"si se añade -name solo se añade ese valor
**out->write( data = ls_flight2 name = `ls_flight2` ).
*
*
*    "CORRESPONDING
*
*    "para que solo se extraigan los campos de una tabla externa
*    "que tengamos en nuestra tabla interna.
**
** "creamos el tipo que asignamos a nuestra tabla
**    TYPES:BEGIN OF ty_flights,
**            carrier_id    TYPE /dmo/carrier_id,
**            connection_id TYPE /dmo/connection_id,
**            flight_date   TYPE /dmo/flight_date,
**          END OF ty_flights.
**
** "crear la tabla
**    DATA: lt_my_flights TYPE STANDARD TABLE OF ty_flights.
** "no haría falta crear estructura: Ls_my_flight type ty_flights.
**
**
**"creamos una nueva tabla a partir de una externa eligiendo todos los campos
**"cuya moneda es EUR
**       SELECT FROM /dmo/flight
**       FIELDS *
**       WHERE currency_code = 'EUR'
**       into table @DATA(lt_flights).
**
** MOVE-CORRESPONDING lt_flights to lt_my_flights.
*    "MOVE-CORRESPONDING lt_flights to lt_my_flights KEEPING TARGET LINES.
*    "KEEP TARGET LINES es opcional y permite que se repitan registros si se hace CORRESPONDING más de una vez.
**
** out->write( data = lt_flights name = 'It_flights' ).
** out->write( |\n| ).
** out->write( data = lt_my_flights name = 'It_my_flights' ).
** "vemos que sólo ha traido los 3 campos de la estructura ty_flights.
*
*    "otra forma de usar CORRESPONDING
*
** SELECT FROM /dmo/flight
**       FIELDS *
**       WHERE currency_code = 'EUR'
**       into table @DATA(lt_flights).
*
**lt_my_flights = CORRESPONDING #( lt_flights ).
**
** out->write( data = lt_flights name = 'It_flights' ).
** out->write( |\n| ).
** out->write( data = lt_my_flights name = 'It_my_flights' ).
**
*    "CHEQUEO DE REGISTROS (comprobar si existe un elemento en la tabla)
*
**    DATA lt_flights TYPE STANDARD TABLE OF /dmo/flight.
**
**    SELECT FROM /dmo/flight
**    FIELDS *
**    WHERE carrier_id = 'LH'
**    INTO TABLE @lt_flights. "en este ejemplo no ponemos DATA porque ya se ha creado la tabla.
*
*    IF sy-subrc = 0.
*
**      READ TABLE lt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
**      "buscamos el campo a ver si se encuentra 0403 en connection_id.
*
*      IF sy-subrc = 0.
*
*        out->write( 'el vuelo extiste' ).
*
*      ELSE.
*        out->write( 'el vuelo no existe' ).
*      ENDIF.
*    ENDIF.
*    """""""""""""""
*    "forma moderna
*
*
**    IF line_exists( lt_flights[ connection_id = '0404' ] ).
**      out->write( ' el vuelo existe en la base de datos' ).
**    ELSE.
**      out->write( 'el vuelo NO existe en la base de datos' ).
*
**
**    ENDIF.
*
*
*    "ÍNDICE DE UN REGISTRO
*
*
**    SELECT FROM /dmo/flight
**   FIELDS *
**   WHERE carrier_id = 'LH'
**   INTO TABLE @DATA(lt_flights).
**
**    READ TABLE lt_flights WITH KEY connection_id = '0404' TRANSPORTING NO FIELDS.
**
**DATA(Lv_index) = sy-tabix. "como el sy-index pero para tablas
**out->write( lt_flights ).
**out->write( lv_index ).
*
*    "forma moderna
**
**SELECT FROM /dmo/flight
**   FIELDS *
**   WHERE carrier_id = 'LH'
**   INTO TABLE @DATA(lt_flights).
**
**data(lv_index) = line_index( lt_flights[ connection_id = '0401' ] ).
**out->write( lt_flights ).
**out->write( lv_index ).
**
**"nº de líneas en la tabla
**data(lv_num) = lines( lt_flights ).
*
*    "LOOP AT
*
** TYPES: BEGIN OF ty_persona,
**             nombre TYPE string,
**             edad   TYPE i,
**           END OF ty_persona.
**
**    TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
**
**
**    DATA(lt_persona) = VALUE ty_tabla_personas(
**    ( nombre = 'Ana' edad = 25 )
**    ( nombre = 'Javier' edad = 45 )
**    ( nombre = 'Lucia' edad = 22 )
**
**
**
**    ).
**
**    out->write( lt_persona ).
**
**    DATA ls_persona TYPE ty_persona.
**
**    LOOP AT lt_persona INTO ls_persona where nombre = 'Ana' .
**
**      out->write( |Nombre: { ls_persona-nombre }, Edad: { ls_persona-edad }| ).
*
*    " ENDLOOP.
*    "loop con assigning field-symbol
*
*
**    SELECT FROM /dmo/flight
**      FIELDS *
**      WHERE carrier_id = 'LH'
**      INTO TABLE @DATA(lt_flights).
**
**    DATA ls_flight TYPE /dmo/flight.
**
**"loop "normal"
**
**    LOOP AT lt_flights INTO ls_flight.
**
**      out->write( data = ls_flight name = `ls_flight` ).
**    ENDLOOP.
**
**
**    """"""""""""""""""""""""""""""
**
**"loop con where y field-symbol
**    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>) WHERE connection_id = '0403'.
**
**      "out->write( data = <fs_flight> name = `<fs_flight>` ).
**    ENDLOOP.
**    out->write( |\n| ).
**    out->write( |\n| ).
**
**
**"loop con where y estructura creada en linea para almacenar valores
**    LOOP AT lt_flights INTO DATA(ls_flight2) WHERE connection_id = '0403'.
**
**      out->write( data = ls_flight2 name = `fs_flight2` ).
**
**    ENDLOOP.
*
*    """""""""""""""2
**
**SELECT FROM /dmo/flight
**      FIELDS *
**      WHERE carrier_id = 'LH'
**      INTO TABLE @DATA(lt_flights).
**
**    DATA ls_flight TYPE /dmo/flight.
**
**    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>) from 3 to 8.
**
**     <fs_flight>-currency_code = 'COP'.
**    ENDLOOP.
**    out->write( data = lt_flights name = `lt_flights` ).
*
*    "EJERCICIO
*
*    "Anonimización de agencias de viajes
*    "La empresa de turismo internacional "DMO Travel Corp" almacena en la tabla
*    "/DMO/AGENCY información sobre sus agencias distribuidas por todo el mundo.
*    "Cada agencia contiene los siguientes datos: ID de cliente (CLIENT),
*    "ID de agencia (AGENCY_ID), nombre (NAME), dirección (STREET, POSTAL_CODE, CITY),
*    " país (COUNTRY_CODE), número de teléfono (PHONE_NUMBER), correo electrónico (EMAIL_ADDRESS)
*    "  y página web (WEB_ADDRESS).
*    "Por normativa de protección de datos, se ha solicitado anonimizar
*    "los correos electrónicos de todas aquellas agencias que cumplan simultáneamente
*    "las siguientes condiciones:
*    "No se encuentran en Alemania (es decir, su campo COUNTRY_CODE es distinto de 'DE')
*    "Su página web contiene la palabra 'tour'
*    "Leer todas las entradas de la tabla /DMO/AGENCY en una tabla interna.
*    "Recorrer la tabla interna y aplicar condiciones lógicas combinadas (AND, <>, CP, line_exists...).
*    "Modificar los correos electrónicos de las agencias que cumplan los criterios anteriores, asignándoles 'oculta@demo.com'.
*    "Mostrar el contenido de la tabla antes y después de la modificación usando out->write
*
*
*
*    SELECT FROM /dmo/agency
*    FIELDS *
*    INTO TABLE @DATA(LT_agencias).
*
*
*    out->write( data = lt_agencias name = `Tabla original` ).
*
*    LOOP AT lt_agencias ASSIGNING FIELD-SYMBOL(<fs_agencia>).
*
*      IF ( <fs_agencia>-web_address ) CP '*tour*' AND ( <fs_agencia>-country_code ) <> 'DE'.
*
*
*        <fs_agencia>-email_address = 'oculta@demo.com'.
*
*      ENDIF.
*
*
*    ENDLOOP.
*
*
*    out->write( |\n| ).
*
*    out->write( data = lt_agencias name = `Tabla modificada` ).
*
*
*"FOR (SÓLO CLOUD)
*
*"FOR
*
**types: BEGIN OF ty_flights,
**       iduser type /dmo/customer_id,
**       aircode type /dmo/carrier_id,
**       flightnum type /dmo/connection_id,
**       key type land1,
**       seat type /dmo/plane_seats_occupied,
**       flightdate type /dmo/flight_date,
**       END OF TY_FLIGHTS.
**
**
**
**
**
**
**DATA: lt_flights_info type TABLE of ty_flights,
**      lt_my_flights type table of ty_flights.
**
*
*"for con el until
**
**lt_my_flights = VALUE #( for i = 1 until i > 30 " se declara la variable i. también se puede usar WHILE
**
**        (     iduser = | { 123456 + i } - USER |
**               aircode = 'LH'
**               flightnum = 00001 + i
**               key = 'US'
**               seat = 0 + i
**               flightdate = cl_abap_context_info=>get_system_date(  ) + 1 ) ).
**
**
**out->write( data = lt_my_flights name = `lt_my_flights` ).
*
* "ejemplo con WHILE
** lt_my_flights = VALUE #( for i = 1 WHILE i <= 20
**
**        (     iduser = | { 123456 + i } - USER |
**               aircode = 'LH'
**               flightnum = 00001 + i
**               key = 'US'
**               seat = 0 + i
**               flightdate = cl_abap_context_info=>get_system_date(  ) + 1 ) ).
**
**
**out->write( data = lt_my_flights name = `lt_my_flights` ).
*
*"crear una estructura a partir de una tabla
*
*"for anidado->unimos dos tablas en una nueva tabla sorted
*
*TYPES: BEGIN OF ty_flights,
*             aircode     TYPE /dmo/carrier_id,
*             flightnum   TYPE /dmo/connection_id,
*             flightdate  TYPE /dmo/flight_date,
*             flightprice TYPE /dmo/flight_price,
*             currency    TYPE /dmo/currency_code,
*           END OF ty_flights."creamos los tipos para la nueva tabla conjunta que vamos a crear
*
*
*    SELECT FROM /dmo/flight
*         FIELDS *
*         INTO TABLE @DATA(lt_flights_type). "extraemos de la tabla externa a una nueva tabla interna
*
*    SELECT FROM /dmo/booking_m
*       FIELDS carrier_id, connection_id , flight_price, currency_code
*       INTO TABLE @DATA(lt_airline)
*       UP TO 20 ROWS. "lo mismo desde otra tabla, pero limitándonos a 20 filas
*
*    DATA lt_final TYPE SORTED TABLE OF ty_flights WITH NON-UNIQUE KEY flightprice.
*    "creamos una nueva tabla sorted con una clave no única, que va a ser el precio. usa los tipos de ty_flights
*
*
* "damos valores a la nueva tabla
*    lt_final = VALUE #(
*     FOR ls_flight_type IN lt_flights_type WHERE ( carrier_id = 'AA' )
*     "bucle externo: recorre lt_flights_type filtrando solo los vuelos cuyo carrier es AA
*
*      FOR ls_airline IN lt_airline WHERE (  carrier_id = ls_flight_type-carrier_id )
* "bucle interno. recorre la tabla lt_airline y filtra donde coincide carrier_id y el carrier_id que hemos seleccionado de la otra tabla
*
*                         ( aircode     = ls_flight_type-carrier_id
*                           flightnum   = ls_flight_type-connection_id
*                           flightdate  = ls_flight_type-flight_date
*                           flightprice = ls_airline-flight_price
*                           currency    = ls_airline-currency_code )  ).
*
* "las estructuras se han declarado dentro del FOR
*
*    out->write( data = lt_flights_type name = `lt_flights_type` ).
*    out->write( |\n| ).
*    out->write( data = lt_airline name = `lt_airline` ).
*    out->write( |\n| ).
*    out->write( data = lt_final name = `tabla generada con las dos anteriores` ).
*
*
*    "select "normal"
*
*    SELECT FROM /dmo/flight
*          FIELDS *
*          WHERE carrier_id = 'LH'
*         INTO TABLE @DATA(lt_flights).
*
*
*"select a una tabla interna (no aconsejado hacer )
*    SELECT carrier_id, connection_id, flight_date
*    FROM @lt_flights AS lt
*    INTO TABLE @DATA(lt_flights_copy).
*
*    out->write( data = lt_flights name = `lt_flights` ).
*    out->write( data = lt_flights_copy name = `lt_flights_copy` ).
*
*
*    "sentencia SORT
*    "ordenar tablas ( no tiene sentido para las tablas de tipo shorted) si para las estandar y las hash
*
*out->write( data = lt_flights_copy name = `lt_flights_copy` ).
*sort lt_flights_copy by flight_date DESCENDING connection_id ASCENDING.
*out->write( data = lt_flights_copy name = `lt_flights_copy ordenado` ).
*
*
*
*"MODIFICAR REGISTROS (FORMA CLÁSICA)-no importante
*
*out->write( data = lt_flights name = 'ANTES /LT_FLIGHTS' ).
*
**LOOP AT lt_flights into data(ls_flight).
**ls_flight-flight_date = cl_abap_context_info=>get_system_date(  ).
**
**MODIFY lt_flights from ls_flight INDEX 2.
**
**out->write( data = lt_flights name = 'DESPUÉS /LT_FLIGHTS' ).
*
*"con condicional
*LOOP AT lt_flights into data(ls_flight).
*
*IF ls_flight-connection_id > '0401'.
*ls_flight-connection_id = '4000'.
*
*MODIFY lt_flights from ls_flight INDEX 2.
*
*ENDIF.
*
*ENDLOOP.
*
*out->write( data = lt_flights name = 'DESPUÉS /LT_FLIGHTS' ).
*
*
*
*
*
*
*"MODIFICAR REGISTROS (CLOUD)
*out->write( data = lt_flights name = `ANTES / lt_flights` ).
**
**    LOOP AT lt_flights INTO DATA(ls_flight).
**      IF ls_flight-connection_id > '0401'.
**        "ls_flight-connection_id = cl_abap_context_info=>get_system_date(  ).
**
**        MODIFY lt_flights FROM VALUE #(  connection_id = '4000'
**                                           carrier_id = 'XX'
**                                           plane_type_id   = 'YY'  ) TRANSPORTING carrier_id plane_type_id connection_id .
**      ENDIF.
**    ENDLOOP.
**    out->write( data = lt_flights name = `DESPUES / lt_flights` ).
*
*
*"""" eliminar registros
*
**DATA: lt_flights_struc TYPE STANDARD TABLE OF /dmo/airport,
**      ls_flights_struc TYPE /dmo/airport.
**
**
**SELECT FROM /dmo/airport
**  FIELDS *
**  WHERE country EQ 'US'
**  INTO TABLE @lt_flights_struc.
**
**
**IF sy-subrc EQ 0.
**  out->write( data = lt_flights_struc name = `BEFORE lt_flights_struc` ).
**
**  " Recorremos la tabla para borrar ciertos aeropuertos
**  LOOP AT lt_flights_struc INTO ls_flights_struc.
**
**    " Si el ID del aeropuerto es JFK, BNA o BOS, lo eliminamos
**    IF ls_flights_struc-airport_id = 'JFK' or
**       ls_flights_struc-airport_id = 'BNA' OR
**       ls_flights_struc-airport_id = 'BOS'.
**
**      " Borramos el registro de la tabla interna
**      DELETE TABLE lt_flights_struc FROM ls_flights_struc.
**
**    ENDIF.
**
**  ENDLOOP.
**
**ENDIF.
**
**
**out->write( |\n| ).
**
**
**out->write( data = lt_flights_struc name = `AFTER lt_flights_struc` ).
**
**""""""""
**
**DELETE lt_flights_struc index 2.
**out->write( data = lt_flights_struc name = `AFTER lt_flights_struc` ).
**"""
**DELETE lt_flights_struc from 3 to 6.
**out->write( data = lt_flights_struc name = `AFTER lt_flights_struc` ).
*" campos nulos
*" DELETE lt_flights_struc where city is initial.
*"" campos duplicados
*"delete ADJACENT DUPLICATES FROM lt_flights_struc COMPARING airport_id.
*
**clear lt_flights_struc.
**Free lt_flights_struc.
*
*
*"EJERCICIO
*"Crea una tabla interna con los datos de 15 vuelos simulados. Cada vuelo tendrá:
*"Un ID de usuario (iduser)
*"Un código de aerolínea (aircode)
*"Un número de vuelo (flightnum)
*"Una clave de país (key)
*"Número de asientos ocupados (seat)
*"Fecha del vuelo (flightdate)
*"Utiliza una expresión FOR con UNTIL para crear los datos dinámicamente.
*
*
**lt_my_flights = VALUE #( for i = 1 until i > 30 " se declara la variable i. también se puede usar WHILE
**
**        (     iduser = | { 123456 + i } - USER |
**               aircode = 'LH'
**               flightnum = 00001 + i
**               key = 'US'
**               seat = 0 + i
**               flightdate = cl_abap_context_info=>get_system_date(  ) + 1 ) ).
*
**TYPES: BEGIN OF ty_clave_pais,
**       num_reg type i,
**       clave_pais type string,
**       end of ty_clave_pais.
**
**       TYPES: Ty_tabla_clave_pais TYPE STANDARD TABLE OF ty_clave_pais WITH EMPTY KEY.
**       data lt_clave_pais type ty_tabla_clave_pais.
**       ls_clave_pais = VALUE #( num_reg = 1 clave_pais =  ).
**
**    INSERT ls_libro INTO Lt_libros INDEX 1.
*
*
*
*
**ls_clave_pais type ty_clave_pais.
**
*
*
*
*
*TYPES: BEGIN OF ty_vuelos,
*iduser TYPE i,
*aircode type /dmo/carrier_id,
*flightnum type i,
*key type string,
*seat type /dmo/plane_seats_occupied,
*flightdate type /dmo/flight_date,
*end of ty_vuelos.
*
*TYPES: Ty_tabla_vuelos TYPE STANDARD TABLE OF ty_vuelos WITH EMPTY KEY.
*DATA lt_vuelos TYPE ty_tabla_vuelos.
*DATA ls_vuelos type ty_vuelos.
*
*
*lt_vuelos = VALUE #( for i = 1 until i > 15 "
*
*        (     iduser = 0400 + i
*               aircode = 400 + i
*               flightnum = 00001 + i
*               key = 'ZZ'
*               seat = 10 + i
*               flightdate = cl_abap_context_info=>get_system_date(  ) + 1 ) ).
*
*
*
*
*out->write( data = lt_vuelos name = `ejer 1` ).
*
*
*    LOOP AT lt_vuelos INTO ls_vuelos.
*
*
*    IF ls_vuelos-aircode < '0405'.
*
*           DELETE TABLE lt_vuelos FROM ls_vuelos.
*           endif.
*
*
*endloop.
*out->write( data = lt_vuelos name = `ejer 2` ).
*
*
**    LOOP AT lt_vuelos ASSIGNING FIELD-SYMBOL(<fs_vuelos>).
**
**      IF <fs_vuelos>-seat > 20.
**
**        <fs_vuelos>-aircode = 'UPD'.
**
**        <fs_vuelos>- ect
**
**
**
**
**
**     ENDIF.
**
**
**
**  ENDLOOP.
*
*LOOP AT lt_vuelos INTO ls_vuelos.
*IF ls_vuelos-seat > 20.
*ls_vuelos-aircode = 'UPD'.
*
*MODIFY lt_vuelos from ls_vuelos INDEX ( sy-tabix ).
*
*endif.
*
*endloop.
*
*out->write( data = lt_vuelos name = `ejer 3` ).
*
**"TABLAS DE RANGOS
** sign
**    I  = lo quiero
**    E  = no lo quiero
**
**option dice el tipo de comparacion
**    EQ - =  / igual a
**    NE - diferente de  <>
**    GT - mayor que >
**    LT - Menor que <
**    BT - entre
***    CP - "like"
**
**
**low - El valor minimo o valor exacto
**
**high - el valor maximo
*
*DATA lr_seats type range of /dmo/plane_seats_occupied.
*
*"quiero vuelos con asiesntos entre 50 y 100
*append value #( sign = 'I' option = 'BT' low = 50 high = 100 ) to lr_seats.
*"tambien quiero vuelos exactamente con 150 asisentos
*append value #( sign = 'I' option = 'EQ' low = 150 ) to lr_seats.
*"pero no quiero vuelos con menos de 10 asientos
*append value #( sign = 'E' option = 'EQ' low = 150 ) to lr_seats.
*
*data: lt_flights2 type table of /dmo/flight.
*
*select *
*from /dmo/flight
*where seats_occupied in @lr_seats
*into table @lt_flights.
*
*loop at lt_flights2 into Data(ls_flight2).
*
*out->write( |vuelos: { ls_flight-carrier_id } Asientos ocupados: { ls_flight-seats_occupied } | ).
*ENDLOOP.
*
*
*"SOLUCIÓN PROFE
*
*
*"ENUM
*
*"Enum es una lista de valores con nombre que representa todas las opciones posibles para algo (todas las opciones posibles marcadas por el programador)
*
*
*    "Definimos el ENUM para los tipos de vuelo
*    TYPES : BEGIN OF ENUM ty_flight_enum,
*
*              nacional,   "vuelo dentro del mismo pais
*              internacional, " vuelo entre paises
*              charter, "vuelo especial/privado
*
*            END OF ENUM ty_flight_enum.
*
*    "Declaramos la variable
*    DATA lv_tipo_vuelo TYPE ty_flight_enum.
*
*    "asignamos el valor al ENUM !! que no puede ser distinto a los que esten en la declaracion del   TYPES : BEGIN OF ENUM ty_flight_enum,
*    lv_tipo_vuelo = internacional.
*
*    CASE lv_tipo_vuelo.
*
*      WHEN nacional.
*        out->write( 'este es un vuelo nacional' ).
*
*      WHEN internacional.
*        out->write( 'este es un vuelo internacional' ).
*
*      WHEN charter.
*        out->write( 'este es un vuelo charter' ).
*
*    ENDCASE.
*
*"BASE
*    "Permite reutilizar una estructura o tabla ya existente como base para crear una nueva, sin tener que copiar todo manualmente.
*
*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE currency_code = 'USD'
*    INTO TABLE @DATA(lt_flights).
*
*
*out->write( data = lt_flights name = `lt_flights` ).
*
*
*
*
*data lt_seats TYPE table of /dmo/flight.
*
*lt_seats = value #( base lt_flights
*
*( carrier_id = 'CO'
*  connection_id = '000123'
*  flight_date = sy-datum " cl_abap_context_info=>get_system_date( ).
*  price = '2000'
*  currency_code = 'COP'
*  plane_type_id = 'B213-58'
*  seats_max = 120
*  seats_occupied = 100
*
*) ).
*lt_seats = VALUE #( BASE lt_seats ( LINES OF lt_flights )
*                    ( carrier_id       = 'CO'
*                      connection_id    = '000123'
*                      flight_date      = cl_abap_context_info=>get_system_date( )
*                      price            = '2000'
*                      currency_code    = 'COP'
*                      plane_type_id    = 'B213-58'
*                      seats_max        = 125
*                      seats_occupied   = 100 ) ).
*
*
*out->write( data = lt_seats name = `lt_seats` ).



"agrupación de registros

"agrupar registros
    "En abap cloud( y en abap en general) agrupar registros significa organizar datos con un criterio comun
    "para tratarlos como un conjunto.
    "( se suele hacer cuando se quiere sumar, contar o procesar datos que comparten un mismo valor o varios campos.

    SELECT *
    FROM /dmo/flight
    INTO TABLE @DATA(lt_flights).

    DATA lt_members LIKE lt_flights.

    "bucle externo con agrupacion
    LOOP AT lt_flights INTO DATA(ls_flight) " recorre lt_flights fila a fila en la estructura ls_flgitht
    GROUP BY ls_flight-carrier_id "agrupacion logica por aerolina ( carrier_id)
    ASCENDING "ordena de manera ascendente
    INTO DATA(lv_carrier). "guarda la clave del grupo actual (carrier_id ) en lv_carrier

    clear lt_members. "resetea el acumulador para empezar a llenar el grupo actual

    loop at GROUP lv_carrier into data(ls_member). "itera solo por las filas que pertenecen a este grupo
    append ls_member to lt_members. "añade cada miembro del gurpo a lt_members
    ENDLOOP.



        out->write( |Aerolinea: { lv_carrier } - Vuelos en este grupo: { lines( lt_members ) }  | ).

    ENDLOOP.

""""""""""""""""""""""

    "LET

*    SELECT FROM /dmo/flight
*           FIELDS *
*           WHERE currency_code EQ 'USD'
*           INTO TABLE @DATA(lt_flights).
*
*    SELECT FROM /dmo/booking_m
*           FIELDS *
*           INTO TABLE @DATA(lt_airline)
*           UP TO 50 ROWS.
*
*
*
*
*    LOOP AT lt_flights INTO DATA(ls_flight_let).
*
*      DATA(lv_flights) = CONV string(  " Convertimos todo el resultado a tipo string
*         LET
*           " Buscar en lt_airline el travel_id que corresponde al carrier_id del vuelo actual
*           lv_airline      = lt_airline[ carrier_id = ls_flight_let-carrier_id ]-travel_id
*
*           " Buscar en lt_flights el precio del vuelo con el mismo carrier_id y connection_id
*           lv_flight_price = lt_flights[ carrier_id    = ls_flight_let-carrier_id
*                                         connection_id = ls_flight_let-connection_id ]-price
*
*           " Buscar de nuevo el carrier_id en lt_airline (parece redundante, pero se usa aquí)
*           lv_carrid       = lt_airline[ carrier_id = ls_flight_let-carrier_id ]-carrier_id
*
*         IN
*          " Cadena final con formato: <carrier_id> / Airline name: <travel_id> / Flight price: <precio>
*           | { lv_carrid } / Airline name: { lv_airline } / Flight price: { lv_flight_price } |
*       ).
*      out->write( data = lv_flights ).
*    ENDLOOP.
*
*
*

 ENDMETHOD.





ENDCLASS.




