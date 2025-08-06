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

**    TYPES: BEGIN OF ty_persona, "crear un tipo para la estructura
**            nombre TYPE string,
**            edad TYPE i,
**          END OF ty_persona.
**
**          TYPES: Ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY. "crea un tipo para la tabla
**
**DATA: lt_personas type ty_tabla_personas, "crea la tabla asignándoles un tipo
**      ls_persona type ty_persona. "crea la estructura asignandole un tipo
*
**      ls_persona-nombre = 'Carlos'.
**      ls_persona-edad = 40.
**
**INSERT ls_persona into Lt_personas INDEX 1. "inserta lo que tengas en la estructura en esta tabla, en la fila 1.
**
**       ls_persona-nombre = 'Maria'. "damos otra vez valores a la estructura
**      ls_persona-edad = 30.
**
**INSERT ls_persona into Lt_personas INDEX 2. "insertamos en la línea 2
**"etc
**
**LOOP AT lt_personas into ls_persona. "bucle para imprimir todas las líneas
**out->write( |Nombre: { ls_persona-nombre }, edad { ls_persona-edad } | ).
**
**ENDLOOP.
*
**out->write( lt_personas ). "fuera del loop lo presenta en columnas
*
*    "INSERT VALUE
*
**DATA lt_aeropuerto type STANDARD TABLE OF /dmo/airport.
**insert value #(
**client = 100
**airport_id = 'FRA'
**name = 'Frankfurt Airport'
**city = 'Frankfurt/Main'
**country = 'DE'
**) INTO TABLE lt_aeropuerto.
**
**out->write( lt_aeropuerto ).
*
*
*    "Si queremos enviarlo a una posición en concreto INTO lt_aeropuerto index 1
*
*    "para poner una línea en blanco
*
**insert initial line into table lt_aeropuerto.
**
**"para igualar dos tablas internas usamos el like
**
**DATA lt_aeropuerto2 like Lt_aeropuerto. " la tabla aeropuerto 2 será igual a la lt_aeropuerto
** "(no copia los datos de los campos)
**
**"duplicar el contenido
**
***insert lines of lt_aeropuerto into table lt_aeropuerto2.
**
***insert lines of lt_aeropuerto to 2 into table lt_aeropuerto2. "hasta el segundo registro
**
**insert lines of lt_aeropuerto from 2 to 3 into table lt_aeropuerto2. "del segundo al tercero
**
**out->write( data = lt_aeropuerto name = 'Lt_aeropuerto2' ).
**
**
**"añadir registros con APPEND (sólo funciona en tablas standard)
**
**    TYPES: BEGIN OF ty_persona, "crear un tipo para la estructura
**             nombre TYPE string,
**             edad   TYPE i,
**           END OF ty_persona.
*
*
*
*DATA: lt_persona TYPE ty_tabla_personas,
*ls_persona TYPE ty_persona.
*
*ls_perspna-nombre = 'Saniel'.
*ls_persona-edad = '23'.
*
*APPEND ls_persona   TO lt_personas.
*
*out->write(  lt_personas ).
*
*
*
*
******EJERCICIO
**Una biblioteca quiere guardar información sobre los libros que tiene. Para ello, crea un programa que:
**Defina un tipo de estructura ty_libro con estos campos:
**Título (tipo string)
**Autor (tipo string)
**Número de páginas (tipo i)
**Declare una tabla interna lt_libros y una variable ls_libro de ese tipo.
**Añada tres libros usando INSERT ... INDEX para colocarlos en posiciones concretas.
**Recorra la tabla con un LOOP AT  muestre:
**"Libro corto: <título>" si tiene menos de 150 páginas
**"Libro largo: <título>" si tiene más de 500 páginas
**"Libro estándar: <título>" en otro caso
**Finalmente, muestra toda la tabla con out->write.
*
*
*    TYPES:BEGIN OF ty_libro,
*            titulo            TYPE string,
*            autor             TYPE string,
*            numero_de_paginas TYPE i,
*
*          END OF ty_libro.
*
*
*    TYPES: Ty_tabla_libros TYPE STANDARD TABLE OF ty_libro WITH EMPTY KEY.
*
*    DATA: lt_libros TYPE ty_tabla_libros, "crea tabla
*          ls_libro  TYPE ty_libro.
*
*
*
*    ls_libro = VALUE #( titulo = 'El Quijote' autor =  'Cervantes' numero_de_paginas = 2000 ).
*
*    INSERT ls_libro INTO Lt_libros INDEX 1.
*
*
*    ls_libro = VALUE #( titulo = 'Aprender Toki Pona' autor =  'Sonia Kisa' numero_de_paginas = 90 ).
*
*    INSERT ls_libro INTO Lt_libros INDEX 2.
*
*    ls_libro = VALUE #( titulo = 'SAP para Dummies' autor =  'Pepe López' numero_de_paginas = 300 ).
*
*    INSERT ls_libro INTO Lt_libros INDEX 3.
*
*
*    LOOP AT lt_libros INTO ls_libro.
*      IF Ls_libro-numero_de_paginas < 150.
*        out->write( |libro corto: { ls_libro-titulo } | ).
*
*      ELSEIF Ls_libro-numero_de_paginas  > 500.
*        out->write( |libro largo: { ls_libro-titulo } | ).
*
*      ELSE.
*        out->write( |libro estándar: { ls_libro-titulo } | ).
*
*      ENDIF.
*
*    ENDLOOP.
*
*    out->write( |\n| ).
*    out->write( |\n| ).
*
*    out->write( data = lt_libros  name = 'Catalogo completo de libros' ).
*
*
*"Solución profe
**     " 1. Definimos un tipo de estructura para guardar los datos de los libros
**    TYPES: BEGIN OF ty_libro,
**             titulo   TYPE string,
**             autor    TYPE string,
**             paginas  TYPE i,
**           END OF ty_libro.
**
**    " 2. Declaramos una tabla interna y una estructura temporal
**    TYPES: ty_tabla_libros TYPE STANDARD TABLE OF ty_libro WITH EMPTY KEY.
**
**    DATA: lt_libros TYPE ty_tabla_libros,
**          ls_libro  TYPE ty_libro.
**
**    " 3. Insertamos tres libros en posiciones específicas
**    ls_libro = VALUE #( titulo = 'El principito' autor = 'Antoine de Saint-Exupéry' paginas = 96 ).
**    INSERT ls_libro INTO lt_libros INDEX 1.
**
**    ls_libro = VALUE #( titulo = 'Don Quijote' autor = 'Miguel de Cervantes' paginas = 863 ).
**    INSERT ls_libro INTO lt_libros INDEX 2.
**
**    ls_libro = VALUE #( titulo = 'Cien años de soledad' autor = 'Gabriel García Márquez' paginas = 417 ).
**    INSERT ls_libro INTO lt_libros INDEX 2. "Se insertará en el medio
**
**    " 4. Recorremos la tabla y analizamos la longitud de cada libro
**    LOOP AT lt_libros INTO ls_libro.
**
**      IF ls_libro-paginas < 150.
**        out->write( |Libro corto: { ls_libro-titulo }| ).
**
**      ELSEIF ls_libro-paginas > 500.
**        out->write( |Libro largo: { ls_libro-titulo }| ).
**
**      ELSE.
**        out->write( |Libro estándar: { ls_libro-titulo }| ).
**      ENDIF.
**
**    ENDLOOP.
**
**    " 5. Mostramos la tabla completa
**    out->write( data = lt_libros name = 'Catálogo completo de libros' ).
**
*
****************
*
*"AÑADIR REGISTROS CON EL APPEND
*    "Añade un registro al final de la tabla interna, solo se usa en las standard. hace los mismo que los inserte, mejor usar los insert.
*
**    TYPES: BEGIN OF ty_persona,
**             nombre TYPE string,
**             edad   TYPE i,
**           END OF ty_persona.
**
**  TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
***
**    DATA: lt_personas TYPE ty_tabla_personas,
**          ls_persona  TYPE ty_persona.
***
**
**
**    ls_persona-nombre = 'Daniel'.
**    ls_persona-edad  = '23'.
**
**
**
**    APPEND ls_persona TO lt_personas.
**
**    out->write( lt_personas ).
*
*    """ declaracion lineal del append
*
**    TYPES: BEGIN OF ty_persona,
**             nombre TYPE string,
**             edad   TYPE i,
**           END OF ty_persona.
**
** TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
**
**    DATA: lt_personas TYPE ty_tabla_personas.
**
**APPEND VALUE #(
**
**        nombre = 'Daniel'
**        edad   = 15
**
** ) to lt_personas.
*
*    """"""
*    "copiar contenido de unta tabla a otra
*
*
*
*APPEND LINES OF lt_personas TO lt_personas2.
*
*    APPEND LINES OF lt_personas TO 2 TO  lt_personas2.
*
*    APPEND LINES OF lt_personas FROM 4 TO 6 TO  lt_personas2.
*
*
*    "AÑADIR REGISTROS CON EL VALUE
**    no necesitas declarar previamente una estructura aunque sí los tipos,
**a menos que venga impuesto por una tabla externa.
*
**    TYPES: BEGIN OF ty_persona,
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
**    ).
**
**    out->write( lt_persona ).
**
**    DATA ls_persona TYPE ty_persona.
**
**    LOOP AT lt_persona INTO ls_persona.
**
**      out->write( |Nombre: { ls_persona-nombre }, Edad: { ls_persona-edad }| ).
**
**    ENDLOOP.
*
*"extraemos todo de la base de datos / la tabla externa
*data lt_aeropuerto type STANDARD TABLE OF /dmo/airport.
*
*lt_aeropuerto = value #(
*
*        (
*        client = 100
*        airport_id = 'FRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'DE'
*        )
*
*                (
*        client = 100
*        airport_id = 'RRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'RE'
*        )
*).
*
*out->write( lt_aeropuerto ).
*
***************************************
**Read table con índice
*
**SELECT from /dmo/airport
**FIELDS *
**where country = 'DE' "selecciona todos los campos donde country es DE
**into table @DATA(lt_flights). "guarda el resultado de a consulta en una nueva tabla . en ABAP clásico la tabla se debe crear manualmente,
**"pero en Cloud se hace así diréctamente.
**
**if sy-subrc = 0. "si es distinto a 0 cuando hay una excepción técnica. si no ha encontrado registros es 4.
**out->write( lt_flights ).
**
**READ table lt_flights into data(ls_flights) index 4. "lee una línea de la tabla y lo almacenamos en una estructura (creada implícitamente en línea)
**endif.
**out->write( data = lt_flights name = 'tabla de vuelos' ).
**out->write( data = ls_flights name = 'estructura de vuelos' ).
**
**READ table lt_flights into data(ls_flights2) index 4 TRANSPORTING airport_id city.
**"se lleva los campos airport_id y city a la nueva estructura ls_flights2
**out->write( data = ls_flights2 name = 'Estructura vuelos' ).
**
**endif.
*
*"field symbol
*
*SELECT from /dmo/airport
*FIELDS *
*where country = 'DE' "selecciona todos los campos donde country es DE
*into table @DATA(lt_flights). "guarda el resultado de a consulta en una nueva tabla . en ABAP clásico la tabla se debe crear manualmente,
*"pero en Cloud se hace así diréctamente.
*
*if sy-subrc = 0. "si es distinto a 0 cuando hay una excepción técnica. si no ha encontrado registros es 4.
*out->write( lt_flights ).
*
*READ table lt_flights ASSIGNING FIELD-SYMBOL(<lsf_flight>) index 3.
*out->write( data = <lsf_flight> name = `<lfs_flight>)` ).
*
*"forma moderna de usar read table con índice
*
*DATA(ls_data) = lt_fligths[ 2 ].
*out->write( data = ls_data name = 'ls_data' ).
*DATA(ls_data2) = value #( lt_fligths[ 28 ] default lt_flights[ 1 ] ).
*"si no me encuentra la línea 28, muestra la 1. hay que poner value # si se utiliza el default
*
*endif.
*
*"read table con clave
*
*IF  sy-subrc = 0.
*
*READ TABLE Ll_flights into data(ls_flight) WITH KEY city = 'Berlín'.
*out->write( data = lt_flights name 'lt_flights' ).
*out->write( data = lt_flights name 'ls_flight' ).
*
*Endif.
*
*
*"forma moderna de leer tabla con clave
*
*
**DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ].
**out->write( data = ls_flight2 name = `ls_flight2` ).
*
*"""
*DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ]-name.
*"si se añade -name solo se añade ese valor
*out->write( data = ls_flight2 name = `ls_flight2` ).


    "CORRESPONDING

    "para que solo se extraigan los campos de una tabla externa
    "que tengamos en nuestra tabla interna.
*
* "creamos el tipo que asignamos a nuestra tabla
    TYPES:BEGIN OF ty_flights,
            carrier_id    TYPE /dmo/carrier_id,
            connection_id TYPE /dmo/connection_id,
            flight_date   TYPE /dmo/flight_date,
          END OF ty_flights.
*
* "crear la tabla
    DATA: lt_my_flights TYPE STANDARD TABLE OF ty_flights.
* "no haría falta crear estructura: Ls_my_flight type ty_flights.
*
*
*"creamos una nueva tabla a partir de una externa eligiendo todos los campos
*"cuya moneda es EUR
*       SELECT FROM /dmo/flight
*       FIELDS *
*       WHERE currency_code = 'EUR'
*       into table @DATA(lt_flights).
*
* MOVE-CORRESPONDING lt_flights to lt_my_flights.
    "MOVE-CORRESPONDING lt_flights to lt_my_flights KEEPING TARGET LINES.
    "KEEP TARGET LINES es opcional y permite que se repitan registros si se hace CORRESPONDING más de una vez.
*
* out->write( data = lt_flights name = 'It_flights' ).
* out->write( |\n| ).
* out->write( data = lt_my_flights name = 'It_my_flights' ).
* "vemos que sólo ha traido los 3 campos de la estructura ty_flights.

    "otra forma de usar CORRESPONDING

* SELECT FROM /dmo/flight
*       FIELDS *
*       WHERE currency_code = 'EUR'
*       into table @DATA(lt_flights).

*lt_my_flights = CORRESPONDING #( lt_flights ).
*
* out->write( data = lt_flights name = 'It_flights' ).
* out->write( |\n| ).
* out->write( data = lt_my_flights name = 'It_my_flights' ).
*
    "CHEQUEO DE REGISTROS (comprobar si existe un elemento en la tabla)

*    DATA lt_flights TYPE STANDARD TABLE OF /dmo/flight.
*
*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE carrier_id = 'LH'
*    INTO TABLE @lt_flights. "en este ejemplo no ponemos DATA porque ya se ha creado la tabla.

    IF sy-subrc = 0.

*      READ TABLE lt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
*      "buscamos el campo a ver si se encuentra 0403 en connection_id.

      IF sy-subrc = 0.

        out->write( 'el vuelo extiste' ).

      ELSE.
        out->write( 'el vuelo no existe' ).
      ENDIF.
    ENDIF.
    """""""""""""""
    "forma moderna


*    IF line_exists( lt_flights[ connection_id = '0404' ] ).
*      out->write( ' el vuelo existe en la base de datos' ).
*    ELSE.
*      out->write( 'el vuelo NO existe en la base de datos' ).

*
*    ENDIF.


    "ÍNDICE DE UN REGISTRO


*    SELECT FROM /dmo/flight
*   FIELDS *
*   WHERE carrier_id = 'LH'
*   INTO TABLE @DATA(lt_flights).
*
*    READ TABLE lt_flights WITH KEY connection_id = '0404' TRANSPORTING NO FIELDS.
*
*DATA(Lv_index) = sy-tabix. "como el sy-index pero para tablas
*out->write( lt_flights ).
*out->write( lv_index ).

    "forma moderna
*
*SELECT FROM /dmo/flight
*   FIELDS *
*   WHERE carrier_id = 'LH'
*   INTO TABLE @DATA(lt_flights).
*
*data(lv_index) = line_index( lt_flights[ connection_id = '0401' ] ).
*out->write( lt_flights ).
*out->write( lv_index ).
*
*"nº de líneas en la tabla
*data(lv_num) = lines( lt_flights ).

    "LOOP AT

* TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*    TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
*
*
*    DATA(lt_persona) = VALUE ty_tabla_personas(
*    ( nombre = 'Ana' edad = 25 )
*    ( nombre = 'Javier' edad = 45 )
*    ( nombre = 'Lucia' edad = 22 )
*
*
*
*    ).
*
*    out->write( lt_persona ).
*
*    DATA ls_persona TYPE ty_persona.
*
*    LOOP AT lt_persona INTO ls_persona where nombre = 'Ana' .
*
*      out->write( |Nombre: { ls_persona-nombre }, Edad: { ls_persona-edad }| ).

    " ENDLOOP.
    "loop con assigning field-symbol


*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
*
*    DATA ls_flight TYPE /dmo/flight.
*
*"loop "normal"
*
*    LOOP AT lt_flights INTO ls_flight.
*
*      out->write( data = ls_flight name = `ls_flight` ).
*    ENDLOOP.
*
*
*    """"""""""""""""""""""""""""""
*
*"loop con where y field-symbol
*    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>) WHERE connection_id = '0403'.
*
*      "out->write( data = <fs_flight> name = `<fs_flight>` ).
*    ENDLOOP.
*    out->write( |\n| ).
*    out->write( |\n| ).
*
*
*"loop con where y estructura creada en linea para almacenar valores
*    LOOP AT lt_flights INTO DATA(ls_flight2) WHERE connection_id = '0403'.
*
*      out->write( data = ls_flight2 name = `fs_flight2` ).
*
*    ENDLOOP.

    """""""""""""""2
*
*SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
*
*    DATA ls_flight TYPE /dmo/flight.
*
*    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>) from 3 to 8.
*
*     <fs_flight>-currency_code = 'COP'.
*    ENDLOOP.
*    out->write( data = lt_flights name = `lt_flights` ).

    "EJERCICIO

    "Anonimización de agencias de viajes
    "La empresa de turismo internacional "DMO Travel Corp" almacena en la tabla
    "/DMO/AGENCY información sobre sus agencias distribuidas por todo el mundo.
    "Cada agencia contiene los siguientes datos: ID de cliente (CLIENT),
    "ID de agencia (AGENCY_ID), nombre (NAME), dirección (STREET, POSTAL_CODE, CITY),
    " país (COUNTRY_CODE), número de teléfono (PHONE_NUMBER), correo electrónico (EMAIL_ADDRESS)
    "  y página web (WEB_ADDRESS).
    "Por normativa de protección de datos, se ha solicitado anonimizar
    "los correos electrónicos de todas aquellas agencias que cumplan simultáneamente
    "las siguientes condiciones:
    "No se encuentran en Alemania (es decir, su campo COUNTRY_CODE es distinto de 'DE')
    "Su página web contiene la palabra 'tour'
    "Leer todas las entradas de la tabla /DMO/AGENCY en una tabla interna.
    "Recorrer la tabla interna y aplicar condiciones lógicas combinadas (AND, <>, CP, line_exists...).
    "Modificar los correos electrónicos de las agencias que cumplan los criterios anteriores, asignándoles 'oculta@demo.com'.
    "Mostrar el contenido de la tabla antes y después de la modificación usando out->write



    SELECT FROM /dmo/agency
    FIELDS *
    INTO TABLE @DATA(LT_agencias).


out->write( data = lt_agencias name = `Tabla original` ).

    LOOP AT lt_agencias ASSIGNING FIELD-SYMBOL(<fs_agencia>).

      IF ( <fs_agencia>-web_address ) CP '*tour*' AND ( <fs_agencia>-country_code ) <> 'DE'.


        <fs_agencia>-email_address = 'oculta@demo.com'.



      ENDIF.


    ENDLOOP.


    out->write( |\n| ).

    out->write( data = lt_agencias name = `Tabla modificada` ).




  ENDMETHOD.


ENDCLASS.




