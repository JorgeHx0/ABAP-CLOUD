CLASS zcl_ejercicios_tablas_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_ejercicios_tablas_jpfb IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

*"EJERCICIO 1
*"Crea una tabla interna con los datos de 15 vuelos simulados. Cada vuelo tendrá:
*"Un ID de usuario (iduser)
*"Un código de aerolínea (aircode)
*"Un número de vuelo (flightnum)
*"Una clave de país (key)
*"Número de asientos ocupados (seat)
*"Fecha del vuelo (flightdate)
*"Utiliza una expresión FOR con UNTIL para crear los datos dinámicamente.
*
*"Solución profe
**TYPES: BEGIN OF ty_flight,
**         iduser     TYPE /dmo/customer_id,
**         aircode    TYPE /dmo/carrier_id,
**         flightnum  TYPE /dmo/connection_id,
**         key        TYPE land1,
**         seat       TYPE /dmo/plane_seats_occupied,
**         flightdate TYPE /dmo/flight_date,
**       END OF ty_flight.
**
**DATA: lt_flights TYPE TABLE OF ty_flight.
**
**" Generamos 15 vuelos con datos ficticios usando FOR ... UNTIL
**    lt_flights = VALUE #( FOR i = 1 UNTIL i > 15
**      ( iduser     = |{ 123000 + i }|         " 123001, 123002, ...
**        aircode    = 'LH'
**        flightnum  = |04{ i WIDTH = 2 PAD = '0' }|
**        key        = 'US'
**        seat       = i + 10
**        flightdate = cl_abap_context_info=>get_system_date( ) + i ) ).
**
**out->write( data = lt_flights name = `lt_flights` ).
*
*"EJER 2
*"Con la tabla de vuelos del ejercicio anterior, elimina todos los vuelos
*"cuyo número de vuelo sea menor que '0405'.
*
*"solución profe
*
*out->write( |\n| ).
**
**LOOP AT lt_flights INTO DATA(ls_flight).
**  IF ls_flight-flightnum < '0405'.
**    DELETE lt_flights FROM ls_flight.
**  ENDIF.
**ENDLOOP.
**
**out->write( data = lt_flights name = `Después del borrado` ).
**
**
*
*
*"EJER 3
*"Actualiza la tabla interna lt_flights para:
*"Cambiar la aircode a 'UPD' si seat es mayor a 20.
*"Cambiar el flightdate al día actual para esos mismos vuelos.
*
*"solución profe
*
**LOOP AT lt_flights INTO ls_flight.
**  IF ls_flight-seat > 20.
**    ls_flight-aircode    = 'UPD'.
**    ls_flight-flightdate = cl_abap_context_info=>get_system_date( ).
**
**    " Se usa MODIFY con TRANSPORTING para actualizar solo los campos deseados
**    MODIFY lt_flights FROM ls_flight TRANSPORTING aircode flightdate.
**  ENDIF.
**ENDLOOP.
*
**
**
***"""OTRA FORMA con los field-symbol
***" Actualiza aircode y flightdate cuando seat > 20 usando FIELD-SYMBOLS
***LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<ls_flight>).
***  IF <ls_flight>-seat > 20.
***    <ls_flight>-aircode    = 'UPD'.
***    <ls_flight>-flightdate = cl_abap_context_info=>get_system_date( ).
***
***    " Con ASSIGNING, ya estás modificando la línea real de la tabla.
***    " Si quieres ser explícito, puedes usar una de estas dos (opcional):
***    " MODIFY CURRENT LINE TRANSPORTING aircode flightdate.
***    " MODIFY lt_flights FROM <ls_flight> TRANSPORTING aircode flightdate INDEX sy-tabix.
***  ENDIF.
***ENDLOOP.
***""""""""""""2
*
**
**out->write( data = lt_flights name = `Después de modificar` ).
*
*"EJER 4
*"Crea dos tablas internas:
*"lt_vuelos: contiene información de vuelos (aerolínea, número de vuelo y fecha).
*"lt_precios: contiene información de precios de vuelo por aerolínea y número de vuelo.
*"Crea una tercera tabla lt_resultado que combine los datos de ambas, solo si coinciden en aircode y flightnum.
*"Usa una expresión VALUE #( FOR ... FOR ... ) (for anidado) para construir la tabla resultado.
*
*"Tipos y datos simulados:
*
*TYPES: BEGIN OF ty_vuelo,
*         aircode    TYPE /dmo/carrier_id,
*         flightnum  TYPE /dmo/connection_id,
*         flightdate TYPE /dmo/flight_date,
*       END OF ty_vuelo.
*
*TYPES: BEGIN OF ty_precio,
*         aircode     TYPE /dmo/carrier_id,
*         flightnum   TYPE /dmo/connection_id,
*         flightprice TYPE /dmo/flight_price,
*         currency    TYPE /dmo/currency_code,
*       END OF ty_precio.
*
*TYPES: BEGIN OF ty_resultado,
*         aircode     TYPE /dmo/carrier_id,
*         flightnum   TYPE /dmo/connection_id,
*         flightdate  TYPE /dmo/flight_date,
*         flightprice TYPE /dmo/flight_price,
*         currency    TYPE /dmo/currency_code,
*       END OF ty_resultado.
*
*DATA: lt_vuelos     TYPE STANDARD TABLE OF ty_vuelo,
*      lt_precios    TYPE STANDARD TABLE OF ty_precio,
*      lt_resultado  TYPE STANDARD TABLE OF ty_resultado.
*
*
*      "solución ejer 4:
*
**          "-----------------------------
**    " 1) Definición de tipos
**    "-----------------------------
**    TYPES: BEGIN OF ty_vuelo,
**             aircode    TYPE /dmo/carrier_id,     " Aerolínea (p.ej. 'AA', 'LH')
**             flightnum  TYPE /dmo/connection_id,  " Nº de vuelo (p.ej. '0401')
**             flightdate TYPE /dmo/flight_date,    " Fecha del vuelo
**           END OF ty_vuelo.
**
**    TYPES: BEGIN OF ty_precio,
**             aircode     TYPE /dmo/carrier_id,     " Aerolínea
**             flightnum   TYPE /dmo/connection_id,  " Nº de vuelo
**             flightprice TYPE /dmo/flight_price,   " Precio
**             currency    TYPE /dmo/currency_code,  " Moneda
**           END OF ty_precio.
**
**    TYPES: BEGIN OF ty_resultado,
**             aircode     TYPE /dmo/carrier_id,
**             flightnum   TYPE /dmo/connection_id,
**             flightdate  TYPE /dmo/flight_date,
**             flightprice TYPE /dmo/flight_price,
**             currency    TYPE /dmo/currency_code,
**           END OF ty_resultado.
**
**    " Tablas internas resultado y de datos
**    DATA: lt_vuelos     TYPE STANDARD TABLE OF ty_vuelo,
**          lt_precios    TYPE STANDARD TABLE OF ty_precio,
**          lt_resultado  TYPE STANDARD TABLE OF ty_resultado.
*
*    "------------------------------------------
*    " 2) Carga de DATOS SIMULADOS (no de BBDD)
*    "------------------------------------------
*    " Dos vuelos de AA y uno de LH; uno de ellos NO tendrá precio para que se vea
*    " que el join por FOR anidado solo devuelve coincidencias.
*    lt_vuelos = VALUE #(
*      ( aircode = 'AA' flightnum = '0401' flightdate = '20250731' )
*      ( aircode = 'AA' flightnum = '0402' flightdate = '20250801' )
*      ( aircode = 'LH' flightnum = '0500' flightdate = '20250815' )
*    ).
*
*    " Precios: uno para AA-0401 y otro para LH-0500.
*    " Deliberadamente NO ponemos precio de AA-0402 para comprobar el filtrado.
*    lt_precios = VALUE #(
*      ( aircode = 'AA' flightnum = '0401' flightprice = '399.00' currency = 'USD' )
*      ( aircode = 'LH' flightnum = '0500' flightprice = '520.00' currency = 'EUR' )
*      " ( aircode = 'AA' flightnum = '0402' ... )  -> a propósito no existe
*    ).
*
*    " Mostrar datos de partida
*    out->write( data = lt_vuelos  name = `lt_vuelos (datos simulados)` ).
*    out->write( data = lt_precios name = `lt_precios (datos simulados)` ).
*
*    "---------------------------------------------------------------------------------
*    " 3) Construcción de lt_resultado con VALUE #( FOR ... FOR ... )
*    "
*    "    - Primer FOR recorre cada vuelo.
*    "    - Segundo FOR recorre precios PERO filtrados por coincidencia de claves:
*    "        aircode = gs_vuelo-aircode AND flightnum = gs_vuelo-flightnum
*    "    - El paréntesis final (...) crea la línea del tipo ty_resultado
*    "      combinando campos de ambas tablas (equivale a un INNER JOIN en memoria).
*    "---------------------------------------------------------------------------------
*    lt_resultado = VALUE #(
*      FOR gs_vuelo  IN lt_vuelos
*        FOR gs_prec  IN lt_precios
*          WHERE ( aircode  = gs_vuelo-aircode
*                  AND flightnum = gs_vuelo-flightnum )
*          ( aircode     = gs_vuelo-aircode
*            flightnum   = gs_vuelo-flightnum
*            flightdate  = gs_vuelo-flightdate
*            flightprice = gs_prec-flightprice
*            currency    = gs_prec-currency )
*    ).
*
*    "-----------------------------------------
*    " 4) Salida: solo aparecen coincidencias
*    "    Esperado con los datos de ejemplo:
*    "      - AA 0401 (tiene precio)   -> aparece
*    "      - AA 0402 (sin precio)     -> NO aparece
*    "      - LH 0500 (tiene precio)   -> aparece
*    "-----------------------------------------
*    out->write( data = lt_resultado name = `lt_resultado (join por FOR anidado)` ).
*
*
*   "EJERCICIO tabla de rangos
*"Crea un programa que muestre solo los vuelos cuya fecha (flight_date) esté dentro de un rango de fechas específico, usando tablas de rangos.
*"Pasos que debe cumplir:
*"Declarar una tabla de rangos para flight_date.
*"Añadir dos condiciones al rango:
*"Fechas entre '2025-01-01' y '2025-12-31'.
*"Excluir la fecha '2025-06-01'.
*"Usar la tabla de rangos en un SELECT sobre /dmo/flight.
*"Mostrar el carrier_id, connection_id y flight_date de los vuelos que cumplan.
*
*" 1) Declarar la tabla de rangos para flight_date
*DATA lr_dates TYPE RANGE OF /dmo/flight_date.
*
*
*
*" 2) Añadir condición: vuelos entre el 1 de enero y el 31 de diciembre de 2025
*APPEND VALUE #(
*  sign   = 'I'        " Incluir
*  option = 'BT'       " Between
*  low    = '20250101' " Fecha inicial (AAAAMMDD)
*  high   = '20251231' " Fecha final
*) TO lr_dates.
*
*" 3) Añadir condición: excluir vuelos del 1 de junio de 2025
*APPEND VALUE #(
*  sign   = 'E'        " Excluir
*  option = 'EQ'       " Igual a
*  low    = '20250601' " Fecha a excluir
*) TO lr_dates.
*
*" 4) Declarar tabla para guardar resultados
*DATA lt_flights TYPE TABLE OF /dmo/flight WITH EMPTY KEY.
*
*" 5) SELECT usando la tabla de rangos
*SELECT *
*  FROM /dmo/flight
*  WHERE flight_date IN @lr_dates
*  INTO TABLE @lt_flights.
*
*" 6) Mostrar resultados
*LOOP AT lt_flights INTO DATA(ls_flight).
*  out->write(
*    |Carrier: { ls_flight-carrier_id }  Conn: { ls_flight-connection_id }  Fecha: { ls_flight-flight_date }|
*  ).
*ENDLOOP.

"EJERCICIOS FINALES. (enunciadoS en ppt tablas internas ejercicios finales)

"1. FOR

TYPES: BEGIN OF ty_flights,
       iduser type c length 40,
       aircode type /dmo/carrier_id,
       flightnum type /dmo/connection_id,
       key type land1,
       seat type /dmo/plane_seats_occupied,
       flightdate type /dmo/flight_date,
       end of ty_flights.

TYPES: TY_tabla_flights TYPE STANDARD TABLE OF ty_flights WIth empty key.

DATA: lt_flights TYPE ty_tabla_flights,
      lt_flights_info TYPE ty_tabla_flights.


      lt_flights = VALUE #( for i = 1 until i > 15

        (     iduser = | { 1234 + i } - USER |
               aircode = 'SQ'
               flightnum = 0000 + i
               key = 'US'
               seat = 0 + i
               flightdate = cl_abap_context_info=>get_system_date(  ) + 1 ) ).

out->write( lt_flights ).

lt_flights_info = value #( base lt_flights ( ) ).

out->write( data = lt_flights name = 'lt_flights_info' ).



Lt_flights_info = VALUE #( FOR i = 16 THEN i + 1 UNTIL i > 30
(     iduser = | { 1234 + i } - USER |
               aircode = 'CL'
               flightnum = 0000 + 10 * i
               key = 'COP'
               seat = 0 + i
               flightdate = cl_abap_context_info=>get_system_date(  ) + 1 ) ).

out->write( data = lt_flights name = 'lt_flights_info2' ).
endmethod.

ENDCLASS.
