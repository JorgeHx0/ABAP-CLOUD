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
"Mis soluciones. incorrecto!!! ver soluciones del profe abajo
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


lt_flights_info = value #( base lt_flights ( ) ).

out->write( data = lt_flights name = 'lt_flight' ).


DATA lv_valor_flightnum type i.
LOOP AT lt_flights_info into data(ls_estructura).

lv_valor_flightnum = sy-tabix * 10.

MODIFY lt_flights_info FROM VALUE #(  aircode = 'CL'
                                          flightnum = lv_valor_flightnum
                                           key  = 'COP'  ) TRANSPORTING aircode flightnum key.
"otra forma sugerido por chat-gpt
"lt_flights_info[ sy-tabix ]-aircode = 'CL'.
"lt_flights_info[ sy-tabix ]-flightnum = sy-tabix * 10.
"lt_flights_info[ sy-tabix ]-key = 'COP'.


endloop.

data lv_linea_vacia type i.
lv_linea_vacia =  lines( lt_flights_info ).

delete lt_flights_info INDEX lv_linea_vacia .

out->write( data = lt_flights_info name = 'lt_flights_info (modificado)' ).

"2. FOR anidado

DATA: mt_flights_type TYPE TABLE OF /dmo/flight,
      mt_airline TYPE TABLE OF /dmo/connection,
      lt_final TYPE sorted table of ty_flights with non-unique key aircode.


*SELECT
*FROM /dmo/flight
*            fields *
*            into table @mt_flights_type.
*
*            SELECT
*            FROM /dmo/connection
*            FIELDS carrier_id, connection_id, airport_from_id
*            INTO CORRESPONDING FIELDS OF TABLE @mt_airline.
*
*
*
*out->write( data = mt_flights_type name = 'mt_flights_type' ).
*out->write( data = mt_airline name = 'mt_airline' ).
*
*data ls_mt_flights_type2 TYPE /dmo/flight.
*data ls_mt_airline_type TYPE /dmo/flight.
*
*
* lt_final = VALUE #( FOR ls_mt_flights_type in mt_flights_type WHERE ( carrier_id = 'SQ' )
*FOR ls_mt_airline IN mt_airline WHERE ( connection_id = mt_flights_type-connection_id )
*
*                         ( iduser     = ls_mt_flights_type2-client
*                           aircode   = ls_mt_flights_type2-carrier_id
*                           flightnum  = ls_mt_airline_type-connection_id
*                           key = ls_mt_airline_type2-airport_from_id
*                           seat    = ls_mt_flight_type2-seats_occupied
*                            flightdate = ls_mt_flight2_type )  ).
*
*
*"3. Añadir múltiples líneas
*
**TYPES: BEGIN OF ty_airlines,
**       carrier_id type /dmo/carrier_id,
**       connection_id type /dmo/connection_id,
**       airport_from_id type /dmo/airport_from_id,
**       airport_to_id type /dmo/airport_to_id,
**              end of ty_airlines.
**
** data: mt_airlines TYPE TABLE OF ty_airlines.
**
**SELECT
**FROM /dmo/m
**
*
*
*
**LOOP AT lt_flights into data(ls_flight).
**
**IF ls_flight-connection_id > '0401'.
**ls_flight-connection_id = '4000'.
**
**MODIFY lt_flights from ls_flight INDEX 2.
**
**ENDIF.
**
**ENDLOOP
*
*
*"EJERCICIOS FINALES. SOLUCIONES PROFESOR
*
***************************************************************** EJERCICIO 1 *******************************************************************************
*
*    DATA: ls_flight       TYPE ty_flights,                      " WA (work area) con la estructura de una fila del tipo ty_flights
*          lt_flights      TYPE STANDARD TABLE OF ty_flights,    " Itab estándar que contendrá 15 vuelos generados
*          lt_flights_info TYPE STANDARD TABLE OF ty_flights.    " Itab estándar resultado con los vuelos mapeados
*
*    " Construye lt_flights con 15 filas usando FOR (i = 1..15)
*    lt_flights = VALUE ty_flights_tab(                          " Constructor de tabla del tipo ty_flights_tab
*      FOR i = 1 UNTIL i > 15                                    " Bucle generador: crea filas mientras i ≤ 15
*      ( iduser     = |1234{ i }-t100437|                        " iduser con plantilla de texto: 1234 + i + sufijo
*        aircode    = 'SQ'                                       " Código de aerolínea fijado a 'SQ'
*        flightnum  = CONV /dmo/connection_id( i )               " Convierte i al tipo /dmo/connection_id (evita warnings)
*        key        = 'US'                                       " País/clave fijado a 'US' (sin espacios)
*        seat       = CONV /dmo/plane_seats_occupied( i )        " Asientos ocupados = i, convertido a su tipo
*        flightdate = cl_abap_context_info=>get_system_date( ) + i ) ). " Fecha = hoy + i días (DATE aritmética)
*
*    out->write( EXPORTING data = lt_flights name = 'Ej.1: LT_FLIGHTS (base)' ). " Muestra la tabla base generada
*
*    " Mapea/cambia campos a lt_flights_info
*    lt_flights_info = VALUE ty_flights_tab(                     " Nuevo constructor de tabla para la tabla destino
*      FOR ls IN lt_flights                                      " Recorre cada vuelo de la tabla base
*      ( iduser     = ls-iduser                                  " Copia el iduser
*        aircode    = 'CL'                                       " Sustituye aerolínea por 'CL'
*        flightnum  = ls-flightnum + 10                          " Incrementa el nº de vuelo en +10
*        key        = 'COP'                                      " Cambia la clave/país a 'COP'
*        seat       = ls-seat                                    " Copia asientos ocupados
*        flightdate = ls-flightdate ) ).                         " Copia la fecha
*
*    out->write( EXPORTING data = lt_flights_info name = 'Ej.1: LT_FLIGHTS_INFO (mapeada)' ). " Muestra la tabla mapeada
*
*
***************************************************************** EJERCICIO 2 *******************************************************************************
*
*    DATA lt_final TYPE SORTED TABLE OF ty_flights WITH NON-UNIQUE KEY aircode. " Tabla ordenada por 'aircode' permitiendo duplicados
*
*    " Cargar datos base de las tablas demo
*    SELECT FROM /dmo/flight     FIELDS * INTO TABLE @mt_flights_type.          " Selecciona TODOS los vuelos a mt_flights_type
*    SELECT FROM /dmo/connection FIELDS * WHERE carrier_id = 'SQ'               " Selecciona conexiones sólo de la aerolínea 'SQ'
*           INTO TABLE @mt_airlines.
*
*    " Join en memoria: vuelos SQ + su conexión por connection_id
*    lt_final = VALUE ty_flights_tab(                                           " Construye la tabla resultado
*      FOR ls_flights_type IN mt_flights_type WHERE ( carrier_id = 'SQ' )       " Itera los vuelos de la compañía 'SQ'
*      FOR ls_airline      IN mt_airlines     WHERE ( connection_id = ls_flights_type-connection_id ) " Une por connection_id
*      ( iduser     = ls_flights_type-client                                    " Usa el mandante como iduser (tipifica a string)
*        aircode    = ls_flights_type-carrier_id                                " Copia el código de aerolínea
*        flightnum  = ls_airline-connection_id                                  " Toma el nº de conexión de /dmo/connection
*        key        = ls_airline-airport_from_id                                " Pone el aeropuerto de origen como 'key'
*        seat       = ls_flights_type-seats_occupied                            " Copia asientos ocupados del vuelo
*        flightdate = ls_flights_type-flight_date ) ).                           " Copia la fecha del vuelo
*
*    out->write( EXPORTING data = lt_final name = 'Ej.2: Nested FOR (join en memoria)' ). " Muestra el resultado del join
*
*
****************************************************************** EJERCICIO 3 *******************************************************************************
*
*    DATA mt_airlines_sub TYPE ty_airlines_tab.                                 " Subconjunto con sólo 4 columnas (tipo reducido)
*
*    " Selección de subconjunto (sólo columnas requeridas) para origen FRA
*    SELECT carrier_id, connection_id, airport_from_id, airport_to_id           " Selecciona solo estas columnas
*      FROM /dmo/connection                                                      " De la tabla de conexiones
*      WHERE airport_from_id = 'FRA'                                             " Filtra conexiones cuyo origen sea FRA
*      INTO TABLE @mt_airlines_sub.                                              " Vuelca el resultado al subconjunto
*
*    out->write( EXPORTING data = mt_airlines_sub name = 'Ej.3: Multiple lines (FRA)' ). " Muestra el subconjunto
**
**
****************************************************************** EJERCICIO 4 *******************************************************************************
*
*    " Ordenar el subconjunto por connection_id descendente
*    SORT mt_airlines_sub BY connection_id DESCENDING.                           " Ordena Z→A / 999→0 por connection_id
*
*    out->write( EXPORTING data = mt_airlines_sub name = 'Ej.4: Sorted DESC by connection_id' ). " Muestra ordenado
**
**
****************************************************************** EJERCICIO 5 *******************************************************************************
*
*    " Alias mt_spfli del mismo tipo que /dmo/connection (reutiliza lo ya cargado en Ej.2)
*    DATA mt_spfli TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY.       " Crea alias con el tipo de /dmo/connection
*    mt_spfli = mt_airlines.                                                    " Copia las conexiones de 'SQ' cargadas en Ej.2
*
*    " Modificar la hora de salida si es > 12:00 (formato TIMS 'HHMMSS')
*    LOOP AT mt_spfli ASSIGNING FIELD-SYMBOL(<ls_spfli>).                        " Itera editando en sitio (sin WA y sin MODIFY)
*      IF <ls_spfli>-departure_time > '120000'.                                  " Compara TIMS: 12:00:00 → '120000'
*        <ls_spfli>-departure_time = cl_abap_context_info=>get_system_time( ).   " Sustituye por la hora actual del sistema
*      ENDIF.                                                                    " Fin condición
*    ENDLOOP.                                                                    " Fin bucle
*
*    out->write( EXPORTING data = mt_spfli name = 'Ej.5: Modify table (departure_time)' ). " Muestra tabla modificada
*
*
****************************************************************** EJERCICIO 6 *******************************************************************************
*
*    " Eliminar de mt_spfli (alias de /dmo/connection) los registros cuyo destino sea FRA
*    DELETE mt_spfli WHERE airport_to_id = 'FRA'.                               " Elimina filas cuyo destino sea FRA
*    out->write( EXPORTING data = mt_spfli name = 'Ej.6: Deleted airport_to_id = FRA' ). " Muestra tras borrado
*

***************************************************************** EJERCICIO 7 *******************************************************************************
*
*    " Demostración de CLEAR y FREE sobre una itab (usamos el subconjunto de Ej.3: mt_airlines_sub)
*    DATA(lv_before) = lines( mt_airlines_sub ).                                " Guarda nº de filas ANTES (para comparar)
*    CLEAR mt_airlines_sub.                                                     " Vacía el contenido (pero puede dejar capacidad)
*    DATA(lv_after_clear) = lines( mt_airlines_sub ).                           " Cuenta DESPUÉS de CLEAR (debería ser 0)
*    FREE mt_airlines_sub.                                                      " Libera la memoria (capacidad) de la tabla
*    out->write( |Ej.7: entries ANTES={ lv_before } / DESPUÉS CLEAR={ lv_after_clear } / FREE hecho| ). " Traza informativa
*
*
****************************************************************** EJERCICIO 8 *******************************************************************************
**
**    " COLLECT: agregación por clave (carrier_id + connection_id) sumando numéricos
**    DATA lt_seats_src TYPE ty_seats_std.                                       " Fuente con los campos renombrados (seats/bookings)
**    DATA lt_seats     TYPE ty_seats_hashed.                                    " Destino HASHED con clave única para COLLECT
**
**    " Seleccionar sólo lo necesario de /dmo/flight cuando seats_max = 140
**    SELECT FROM /dmo/flight
**           FIELDS carrier_id,                                                 " Clave 1
**                  connection_id,                                             " Clave 2
**                  seats_occupied AS seats,                                   " Campo sumable 1 (renombrado)
**                  price          AS bookings                                 " Campo sumable 2 (renombrado)
**           WHERE seats_max = 140
**           INTO TABLE @lt_seats_src.                                         " Vuelca a la fuente
**
**    " Aplicar COLLECT (suma seats y bookings por clave única)
**    LOOP AT lt_seats_src INTO DATA(ls_s).                                     " Itera cada registro fuente
**      COLLECT ls_s INTO lt_seats.                                             " Si la clave ya existe: suma; si no, inserta
**    ENDLOOP.
**
**    out->write( EXPORTING data = lt_seats name = 'Ej.8: COLLECT seats/bookings por clave' ). " Muestra agregación
**
**
****************************************************************** EJERCICIO 9 *******************************************************************************
**
*    " LET en plantillas puede no estar soportado; versión compatible: precalcula y concatena con salto
*    IF mt_scarr IS INITIAL.                                                    " Si no se ha cargado /dmo/carrier aún…
*      SELECT FROM /dmo/carrier FIELDS * INTO TABLE @mt_scarr.                  " …cárgalo ahora
*    ENDIF.
*
*    DATA(lv_carrier) = COND string( WHEN lines( mt_scarr ) > 0                 " Si hay al menos 1 compañía…
*                                    THEN mt_scarr[ 1 ]-carrier_id ELSE '' ).   " …toma su carrier_id; si no, vacío
*    DATA(lv_price)   = COND string( WHEN lines( mt_flights_type ) > 0          " Si hay vuelos cargados…
*                                    THEN mt_flights_type[ 1 ]-price ELSE 0 ).  " …toma el precio del primero; si no, 0
*
*    DATA(lv_info) =                                                            " Construye una cadena multilínea:
*      |Carrier={ lv_carrier }| &&                                              " 1ª línea: Carrier=...
*      cl_abap_char_utilities=>newline &&                                       " Salto de línea seguro
*      |Price={ lv_price }|.                                                    " 2ª línea: Price=...
*
*    out->write( |Ej.9: { lv_info }| ).                                         " Imprime el bloque de texto
*
**
****************************************************************** EJERCICIO 10 ******************************************************************************
**
*    " Uso de BASE en un constructor de tabla para clonar y sobrescribir una fila
*    DATA lt_flights_base TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY.    " Itab destino para el clonado
*
*    lt_flights_base = VALUE #(                                                 " Constructor de tabla con BASE
*      BASE mt_flights_type                                                     " Copia todas las filas de mt_flights_type
*      ( carrier_id    = mt_flights_type[ 1 ]-carrier_id                        " Añade/sobrescribe 1 fila: misma aerolínea
*        connection_id = mt_flights_type[ 1 ]-connection_id                     " Misma conexión
*        flight_date   = mt_flights_type[ 1 ]-flight_date + 1                   " Fecha desplazada +1 día
*        price         = mt_flights_type[ 1 ]-price * '1.05' ) ).               " Precio incrementado un 5% (conversión implícita)
*
*    out->write( EXPORTING data = lt_flights_base name = 'Ej.10: BASE (clonado + override)' ). " Muestra el clonado
**
**
****************************************************************** EJERCICIO 11 ******************************************************************************
**
*    " Agrupación de registros: miembros por aeropuerto de ORIGEN
*    DATA lt_group_members TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY. " Itab temporal para visualizar miembros
*
*    LOOP AT mt_airlines INTO DATA(ls_conn)                                     " Recorre conexiones de 'SQ'
*         GROUP BY ( from_id = ls_conn-airport_from_id ) INTO DATA(g_from).     " Agrupa por aeropuerto de origen (alias from_id)
*      CLEAR lt_group_members.                                                  " Limpia acumulador de miembros
*      LOOP AT GROUP g_from INTO DATA(ls_m).                                    " Itera los miembros del grupo actual
*        APPEND ls_m TO lt_group_members.                                       " Añade cada miembro al acumulador
*      ENDLOOP.
*      out->write( EXPORTING data = lt_group_members                             " Muestra los miembros del grupo
*                  name = |Ej.11: Miembros grupo FROM={ g_from-from_id }| ).
*    ENDLOOP.                                                                    " Siguiente grupo
*
**
****************************************************************** EJERCICIO 12 ******************************************************************************
**
*    " Agrupar por clave compuesta (carrier_id + connection_id + from + to)
*    LOOP AT mt_airlines INTO ls_conn                                           " Recorre conexiones
*         GROUP BY ( grp = VALUE ty_airlines(                                   " Define la clave compuesta en una estructura
*                         carrier_id      = ls_conn-carrier_id
*                         connection_id   = ls_conn-connection_id
*                         airport_from_id = ls_conn-airport_from_id
*                         airport_to_id   = ls_conn-airport_to_id ) )
*         INTO DATA(g_comp).                                                    " g_comp contiene la clave (estructura grp)
*
*      CLEAR lt_group_members.                                                  " Limpia acumulador
*      LOOP AT GROUP g_comp INTO DATA(ls_m2).                                   " Itera miembros con esa clave compuesta
*        APPEND ls_m2 TO lt_group_members.                                      " Acumula
*      ENDLOOP.
*
*      out->write( EXPORTING data = lt_group_members                             " Muestra los miembros de esa clave
*                  name = |Ej.12: Grupo { g_comp-grp-airport_from_id }→{ g_comp-grp-airport_to_id }| ).
*    ENDLOOP.                                                                    " Siguiente clave compuesta
**
**
****************************************************************** EJERCICIO 13 ******************************************************************************
**
*    " Conteos por from/to con COLLECT (fallback compatible)
*    DATA lt_counts_13 TYPE HASHED TABLE OF ty_from_to_cnt_13                    " Tabla hash con clave from/to
*                      WITH UNIQUE KEY airport_from_id airport_to_id.
*
*    LOOP AT mt_airlines INTO DATA(ls_conn_13).                                  " Itera conexiones
*      DATA(ls_cnt_13) = VALUE ty_from_to_cnt_13(                                " Prepara unidad de conteo
*                            airport_from_id = ls_conn_13-airport_from_id
*                            airport_to_id   = ls_conn_13-airport_to_id
*                            cnt             = 1 ).
*      COLLECT ls_cnt_13 INTO lt_counts_13.                                      " Si existe clave, suma cnt; si no, inserta
*    ENDLOOP.
*
*    out->write( EXPORTING data = lt_counts_13                                    " Muestra los conteos por par from/to
*                name = 'Ej.13: Conteos por from/to (fallback COLLECT)' ).
**
**
****************************************************************** EJERCICIO 14 ******************************************************************************
**
*    " Rangos: seats_occupied entre 200 y 400
*    DATA lt_range TYPE ty_range_seats.                                         " Rango estándar para seats_occupied
*    APPEND VALUE #( sign = 'I' option = 'BT' low = 200 high = 400 ) TO lt_range." Incluye valores entre 200 y 400 (BETWEEN)
*
*    DATA lt_flights_range TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY.   " Tabla resultado del filtro por rango
*    SELECT FROM /dmo/flight FIELDS *                                           " Selecciona todos los campos
*           WHERE seats_occupied IN @lt_range                                   " Filtra usando el rango definido
*           INTO TABLE @lt_flights_range.                                       " Vuelca el resultado
*
*    out->write( EXPORTING data = lt_range         name = 'Ej.14: Rango seats [200..400]' ).       " Muestra el rango
*    out->write( EXPORTING data = lt_flights_range name = 'Ej.14: Vuelos dentro del rango' ).      " Muestra los vuelos filtrados
**
**
****************************************************************** EJERCICIO 15 ******************************************************************************
*
*    " Sustitución del ENUM por constantes (compatible con todas las releases)
*
*    " 1) Tipo base entero para la “moneda”
*    TYPES mty_currency TYPE i.                                     " Tipo simple entero usado para representar la moneda
*
*    " 2) Constantes que representan cada valor (sustituyen al ENUM)
*    CONSTANTS:                                                     " Conjunto de constantes simbólicas
*      c_curr_initial TYPE mty_currency VALUE 0,                    " 0 → estado inicial
*      c_curr_usd     TYPE mty_currency VALUE 1,                    " 1 → USD
*      c_curr_eur     TYPE mty_currency VALUE 2,                    " 2 → EUR
*      c_curr_cop     TYPE mty_currency VALUE 3,                    " 3 → COP
*      c_curr_mex     TYPE mty_currency VALUE 4.                    " 4 → MEX
*
*    " 3) Variable de “moneda” y mapeo a texto
*    DATA lv_curr TYPE mty_currency VALUE c_curr_usd.               " Inicializa en USD
*
*    DATA(lv_curr_tx) = SWITCH string(                              " Traduce el valor entero a texto
*      lv_curr                                                      " Operando a evaluar
*      WHEN c_curr_initial THEN 'Initial'                           " 0 → 'Initial'
*      WHEN c_curr_usd     THEN 'USD'                               " 1 → 'USD'
*      WHEN c_curr_eur     THEN 'EUR'                               " 2 → 'EUR'
*      WHEN c_curr_cop     THEN 'COP'                               " 3 → 'COP'
*      WHEN c_curr_mex     THEN 'MEX'                               " 4 → 'MEX'
*      ELSE 'Unknown' ).                                            " Cualquier otro → 'Unknown'
*
*    out->write( |Ej.15: Moneda actual = { lv_curr_tx }| ).         " Debe mostrar 'USD'
*
*    " 4) Cambio de “moneda” y nuevo mapeo
*    lv_curr = c_curr_eur.                                          " Cambia el valor entero a EUR
*
*    lv_curr_tx = SWITCH string(                                    " Vuelve a traducir a texto tras el cambio
*      lv_curr
*      WHEN c_curr_initial THEN 'Initial'
*      WHEN c_curr_usd     THEN 'USD'
*      WHEN c_curr_eur     THEN 'EUR'
*      WHEN c_curr_cop     THEN 'COP'
*      WHEN c_curr_mex     THEN 'MEX'
*      ELSE 'Unknown' ).
*
*
*    out->write( |Ej.15: Moneda cambiadaa = { lv_curr_tx }| ).       " Debe mostrar 'EUR'
*



  ENDMETHOD.
ENDCLASS.

