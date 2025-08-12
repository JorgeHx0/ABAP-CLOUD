CLASS zcl_pruebasvariadas_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pruebasvariadas_jpfb IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


*WHILE

**la condicion se evalua al principio
**no sabes cuantas veves tienes que iterar
**esperando una condición externa
*
*
*data lv_num type i.
*while lv_num < 10.
*
*out->write(  lv_num ).
*out->write( | iteración = { sy-index }  | ).
*if lv_num > 5.
*exit.
*endif.
*endwhile.
*
*
*
*
*
*
*
*
*
*
*
**switch
*
*do 6 times.
*
*data(lv_value) = SWITCH #( sy-index when 1 then |iteracion 1| when 2 then |iteracion 2 | when 3 then |iteracion 3| ).
*
*" después del then puede haber literales, variables, expresión completa (p. ejemplo dia:&&lv_var), calculos ,atemáticos (lv_var+5) .
**los tipos deben ser los mismos en las 3. No existe en clásico.
*out->write(  lv_value ).
*
*enddo.
*
*


*EJERCICIO IF
*
*Declarar la siguiente variable de tipo I
*Lv_condicional asigándole el valor 7.
*
*Validar si la variable es igual o diferente de 7 utilizando la sentencia "IF/ELSE/ENDIF".
*Para ambos casos moestrar en pantalla un mensaje que identifica si es igual o diferente al valor de la variable.
*Para esta actividad es necesario llamar y asignar nuevamente la variable, una vez con alún otro número.


    out->write( 'VALIDACIÓN DE VARIABLES' ).
    out->write( '-------------------------------------------------------------------------------------------------' ).



    DATA: lv_numero             TYPE i,
          lv_numero_comparacion TYPE i.

    lv_numero = 7.
    lv_numero_comparacion = 7.

    DO.


      "la primera vez que ejecute el DO, el valor de la variable será el indicado, y la segunda y siguientes será aleatorio

      IF sy-index > 1.


        lv_numero = cl_abap_random_int=>create( seed = cl_abap_random=>seed(  ) min = 1 max = 10 )->get_next( ).
        "generamos número aleatorio entre 0 y 10

      ENDIF.

      IF sy-index = 1 AND lv_numero = lv_numero_comparacion.
        out->write( |el número indicado es igual a { lv_numero } | ).

      ELSEIF sy-index = 1 AND lv_numero <> lv_numero_comparacion.
        out->write( |el número indicado es distinto de { lv_numero_comparacion } | ).

      ELSEIF lv_numero <> lv_numero_comparacion AND sy-index > 1.
        out->write( |el número aleatorio { lv_numero } es distinto de { lv_numero_comparacion } | ).
        EXIT.


      ENDIF.

    ENDDO.


    out->write( '***************************************************************' ).
    out->write( '.' ).


*EJERCICIO CASE/ENDCASE

*Declarar la siguiente variable tipo "string"
*lv_string
*
*Validad la variable utilizando la sentencia CASE/ENDCASE en 3 escenarios
*-Para el valor "experis" muestra en pantalla el valor "Academy"
*-Para el valor "SAP" muestra en pantalla el valor "Enterprise software"
*-Para cualquier otro valor distinto de los dos primeros, muestra en pantalla "unknown"
*
*Es necesario realizar varias asignaciones a la variable para validad cada uno de los posibles escenarios y mostrar el resultado por consola.
*Para este caso una opción es crear una subrutina con la sentencia "FORM" en la cual dependiendo de la entrada devuelve la cadena de caracteres correspondiente.


    DATA lv_string TYPE string.

    DATA lv_string_otra TYPE string VALUE 'asignado al azar'.

    DATA lv_resultado TYPE string.



    out->write( 'PRUEBA DE VALIDACIÓN' ).
    out->write( '-------------------------------------------------------------------------------------------------' ).

    DO.


      CASE sy-index.

        WHEN 1.
          lv_string = 'Experis'.

        WHEN 2.
          lv_string = 'SAP'.

        WHEN 3.
          lv_string = Lv_string_otra.

        WHEN 4.
          EXIT.

      ENDCASE.

      CASE lv_string.
        WHEN 'Experis'.
          lv_resultado = 'Academy'.

        WHEN 'SAP'.
          lv_resultado = 'Enterprise Sofware'.

        WHEN OTHERS.
          lv_resultado = 'Unknown'.

      ENDCASE.


      out->write( |{ sy-index }. Se ha seleccionado automáticamente el valor "{ lv_string }", que corresponde a "{ lv_resultado }".| ).

    ENDDO.

    out->write( '***************************************************************' ).
    out->write( '.' ).

*EJERCICIO DO/ENDDO
*
*Declarar la siguiente variable del tipo i
*LV_counter
*
*Realizar 10 iteraciones utilizando la sentencia "DO" y la la condición '10 TIMES" y
* mostrar el valor de la variable "LV_counter" que va aumentando su valor en 1 en cada iteración

    DATA lv_counter TYPE i VALUE 0.


    out->write( |DO/ENDDO | ).

    DO 10 TIMES.

*      lv_counter  = lv_counter + 1.
      lv_counter += 1.

    ENDDO.

    out->write( |la variable vale { lv_counter } | ).
    out->write( '***************************************************************' ).
    out->write( '. ' ).




    ""CHECK
*
*Repetir el bucle anterior liberando o iniciando a 0 la variable Lv_counter pero terminando el ciclo en la séptima vuelta.
* Por último devolver el valor de la variable en cada iteración.

    lv_counter = 0.


    out->write( |CHECK | ).
    out->write( '-------------------------------------------------------------------------------------------------' ).

    DO.

      lv_counter  = lv_counter + 1.
      out->write( |vuelta nº { lv_counter } | ).
      CHECK lv_counter = 7.
      EXIT.

    ENDDO.

    out->write( '***************************************************************' ).
    out->write( |\n| ). "salto de línea

*  EJERCICIO READ TABLES


*  Crear un tipo de estructura ty_pasajero con los campos:
*nombre (string)
*edad (i)
*Declarar una tabla interna de pasajeros lt_pasajeros y cargarla con VALUE con 4 registros. Uno de ellos debe tener edad < 18.
*Insertar un pasajero nuevo en la segunda posición con INSERT ... INDEX.
*Crear una segunda tabla lt_pasajeros_jovenes que contenga solo los pasajeros menores de edad (usa APPEND dentro de un LOOP).
*Leer el pasajero en la posición 3 usando READ TABLE ... INDEX con ASSIGNING y mostrarlo con out->write, solo si sy-subrc = 0.
*Simular un listado de vuelos haciendo un SELECT sobre /dmo/airport con país 'DE' y guardar los resultados en lt_vuelos.
*Si hay resultados (sy-subrc = 0), mostrar el aeropuerto con airport_id = 'MUC' usando READ TABLE moderno:
*DATA(ls_vuelo) = lt_vuelos[ airport_id = 'MUC' ].
*Mostrar por pantalla todas las estructuras relevantes.
*

    out->write( |\n| ).
    out->write( 'Ejercicio Read Tables' ).
    out->write( |\n| ).
    out->write( '1.' ).

    TYPES: BEGIN OF ty_pasajero,
             nombre TYPE string,
             edad   TYPE i,
           END OF ty_pasajero.

    TYPES: Ty_tabla_pasajeros TYPE STANDARD TABLE OF ty_pasajero WITH EMPTY KEY.

    DATA: ls_pasajero  TYPE Ty_pasajero,
          lt_pasajeros TYPE Ty_tabla_pasajeros.


    ls_pasajero = VALUE #( nombre = 'Carlos Martínez' edad = 34 ).
    INSERT ls_pasajero INTO lt_pasajeros INDEX 1.

    ls_pasajero = VALUE #( nombre = 'Sofía Fernández  ' edad = 7 ).
    INSERT ls_pasajero INTO lt_pasajeros INDEX 2.

    ls_pasajero = VALUE #( nombre = 'Felipe Pérez' edad = 26 ).
    INSERT ls_pasajero INTO lt_pasajeros INDEX 3.

    ls_pasajero = VALUE #( nombre = 'Amaya García' edad = 42 ).
    INSERT ls_pasajero INTO lt_pasajeros INDEX 4.

    out->write( data = LT_pasajeros name = 'LISTA DE VIAJEROS' ).

    out->write( |\n| ).

    out->write( '2.' ).

    ls_pasajero-nombre = 'María Sabater'.
    ls_pasajero-edad = 16.

    INSERT ls_pasajero INTO lt_pasajeros INDEX 2.
    out->write( data = LT_pasajeros name = 'LISTA DE VIAJEROS' ).

    out->write( |\n| ).

    out->write( '3.' ).

    out->write( |\n| ).

    DATA lt_pasajeros_jovenes TYPE Ty_tabla_pasajeros.


    LOOP AT lt_pasajeros INTO ls_pasajero.

      IF ls_pasajero-edad < 18.
        APPEND ls_pasajero TO lt_pasajeros_jovenes.

      ENDIF.

    ENDLOOP.

    out->write( data = lt_pasajeros_jovenes name = 'PASAJEROS JÓVENES' ).


    out->write( |\n| ).


    out->write( '4. ' ).

    IF sy-subrc = 0.

    READ table lt_pasajeros ASSIGNING FIELD-SYMBOL(<lsf_pasajero>) index 3.
    out->write( data = <lsf_pasajero> name = `pasajero en tercera posición` ).

    ELSE.
    out->write( 'no se encuentra el dato' ).

    ENDIF.

    out->write( |\n| ).

    out->write( '5.' ).

IF sy-subrc = 0.

SELECT from /dmo/airport
FIELDS *
where country = 'DE'
into table @DATA(lt_vuelos).

READ TABLE Lt_vuelos into data(ls_vuelos) WITH KEY airport_id = 'MUC'.
out->write( ls_vuelos ).


ELSE.
out->write( 'no se encuentra el vuelo' ).

endif.


"CREACIÓN TABLA CON DATOS SIMULADOS
"Crea una tabla interna con los datos de 15 vuelos simulados. Cada vuelo tendrá:
"Un ID de usuario (iduser)
"Un código de aerolínea (aircode)
"Un número de vuelo (flightnum)
"Una clave de país (key)
"Número de asientos ocupados (seat)
"Fecha del vuelo (flightdate)
"Utiliza una expresión FOR con UNTIL para crear los datos dinámicamente.


"extraemos una lista de códigos de aerolíneas
SELECT carrier_id
FROM /dmo/carrier
INTO TABLE @DATA(lt_lista_carrier).

out->write( lt_lista_carrier ).

"creamos una nueva tabla que relacione aerolíneas y país

TYPES: BEGIN OF ty_aerolineas_pais,
aerolineas type /dmo/carrier-carrier_id,
pais type string,
end of ty_aerolineas_pais.

DATA: lt_aerolineas_pais TYPE STANDARD TABLE OF ty_aerolineas_pais WITH EMPTY KEY,
      ls_aerolineas_pais TYPE ty_aerolineas_pais.

LOOP AT lt_lista_carrier ASSIGNING FIELD-SYMBOL(<fs_1>).
ls_aerolineas_pais-aerolineas  = <fs_1>-carrier_id. "

 case <fs_1>-carrier_id.
 when 'AA'.
  ls_aerolineas_pais-pais = 'US'.
  when 'AC'.
  ls_aerolineas_pais-pais = 'CA'.
  when 'AF'.
  ls_aerolineas_pais-pais = 'FR'.
   when 'AF'.
  ls_aerolineas_pais-pais = 'IT'.
   when 'BA'.
  ls_aerolineas_pais-pais = 'GB'.
   when 'FJ'.
  ls_aerolineas_pais-pais = 'FJ'.
   when 'CO'.
  ls_aerolineas_pais-pais = 'GR'.
   when 'DL'.
  ls_aerolineas_pais-pais = 'US'.
   when 'LG'.
  ls_aerolineas_pais-pais = 'DE'.
   when 'NG'.
  ls_aerolineas_pais-pais = 'IQ'.
WHEN OTHERS.
  ls_aerolineas_pais-pais = 'ZZ'.

  endcase.
  APPEND ls_aerolineas_pais TO lt_aerolineas_pais.
ENDLOOP.

out->write( lt_aerolineas_pais ).

"extraer una aereolínea y su correspondiente país de forma aleatoria


"creación de tabla

*TYPES: BEGIN OF Ty_vuelos_simulados,
*       iduser type /dmo/customer_id,
*       aircode type /dmo/carrier_id,
*       flightnum  TYPE /dmo/connection_id,
*       key        TYPE land1,
*       seat       TYPE /dmo/plane_seats_occupied,
*       flightdate TYPE /dmo/flight_date,
*
*       end of Ty_vuelos_simulados.

*  data lt_vuelos_simulados TYPE TABLE OF ty_vuelos_simulados.
*data ls_vuelo TYPE ty_vuelos_simulados.
*
*       do 19 times.

*DATA(lv_aleatorio) = cl_abap_random_int=>create(  seed = cl_abap_random=>seed(  ) min = 1 max = 19 )->get_next(  ).
*data(lv_vueltas) = sy-index.
*       Ls_vuelo = VALUE #(
*
*      iduser =  400 + lv_vueltas
*       aircode = lt_aerolineas_pais[ lv_aleatorio ]-aerolineas
*       flightnum  = |04{ lv_vueltas WIDTH = 2 PAD = '0' }|
*       key = lt_aerolineas_pais[ lv_aleatorio ]-pais
*       seat = lv_vueltas + 10
*      flightdate = cl_abap_context_info=>get_system_date( ) + lv_vueltas.
*
*
*
*
*       enddo.


TYPES: BEGIN OF ty_vuelos_simulados,
         iduser     TYPE /dmo/customer_id,
         aircode    TYPE /dmo/carrier_id,
         flightnum  TYPE /dmo/connection_id,
         key        TYPE land1,
         seat       TYPE /dmo/plane_seats_occupied,
         flightdate TYPE /dmo/flight_date,
       END OF ty_vuelos_simulados.

DATA: lt_vuelos_simulados TYPE TABLE OF ty_vuelos_simulados.

DO 19 TIMES.
  DATA(lv_aleatorio) = cl_abap_random_int=>create(
                         seed = cl_abap_random=>seed( )
                         min  = 1
                         max  = 19 )->get_next( ).

  DATA(lv_vueltas) = sy-index.

  APPEND VALUE ty_vuelos_simulados(
    iduser     = 400 + lv_vueltas
    aircode    = lt_aerolineas_pais[ lv_aleatorio ]-aerolineas
    flightnum  = |04{ lv_vueltas WIDTH = 2 PAD = '0' }|
    key        = lt_aerolineas_pais[ lv_aleatorio ]-pais
    seat       = lv_vueltas + 10
    flightdate = cl_abap_context_info=>get_system_date( ) + lv_vueltas
  ) TO lt_vuelos_simulados.
ENDDO.


out->write( lt_vuelos_simulados ).

*       ) )
**       FOR ... UNTIL
*    lt_flights = VALUE #( FOR i = 1 UNTIL i > 15
*      ( iduser     = |{ 123000 + i }|         " 123001, 123002, ...
*        aircode    = 'LH'
*        flightnum  = |04{ i WIDTH = 2 PAD = '0' }|
*        key        = 'US'
*        seat       = i + 10
*        flightdate = cl_abap_context_info=>get_system_date(



ENDMETHOD.

ENDCLASS.












