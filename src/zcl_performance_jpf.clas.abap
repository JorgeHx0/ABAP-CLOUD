CLASS zcl_performance_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.




CLASS zcl_performance_jpf IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.
"---------------------------------------------------------------------------------
" Definición de un tipo de tabla interna con filas de /dmo/flight
" Clave primaria NO única por (carrier_id, connection_id, flight_date)
" → permitirá duplicados en esa combinación pero servirá para ordenar por defecto
"---------------------------------------------------------------------------------
TYPES lty_flights TYPE STANDARD TABLE OF /dmo/flight
                  WITH NON-UNIQUE KEY carrier_id connection_id flight_date.

"---------------------------------------------------------------------------------
" Declaración de la tabla interna que usaremos en los ejemplos de ordenación
"---------------------------------------------------------------------------------
DATA lt_flights TYPE lty_flights.                          " Itab de vuelos con la clave anterior

"---------------------------------------------------------------------------------
" Carga manual de datos de ejemplo usando constructor VALUE #( ... ).
" Nota: muchos campos de /dmo/flight son DATS, NUMC o DEC → las comillas serán
"       convertidas implícitamente (si prefieres, puedes usar CONV <tipo>( ... )).
"       flight_date es DATS (YYYYMMDD), price suele ser DEC / CURR.
"---------------------------------------------------------------------------------
lt_flights = VALUE #(
  ( client         = sy-mandt                                " Mandante actual del sistema
    carrier_id     = 'CO'                                    " Compañía aérea
    connection_id  = '0500'                                  " Conexión (NUMC/char con ceros a la izquierda)
    flight_date    = '20250201'                              " Fecha de vuelo (YYYYMMDD)
    plane_type_id  = '123-456'                               " Tipo de avión (texto)
    price          = '1000'                                  " Precio (se convertirá a DEC/CURR si aplica)
    currency_code  = 'COP' )                                 " Moneda

  ( client         = sy-mandt
    carrier_id     = 'MX'
    connection_id  = '0600'
    flight_date    = '20250120'
    plane_type_id  = '747-400'
    price          = '800'
    currency_code  = 'MXN' )

  ( client         = sy-mandt
    carrier_id     = 'QF'
    connection_id  = '0006'
    flight_date    = '20230112'
    plane_type_id  = 'A380'
    price          = '1600'
    currency_code  = 'AUD' )

  ( client         = sy-mandt
    carrier_id     = 'SP'
    connection_id  = '0700'
    flight_date    = '20250610'
    plane_type_id  = '321-654'
    price          = '100'
    currency_code  = 'EUR' )

  ( client         = sy-mandt
    carrier_id     = 'LX'
    connection_id  = '0900'
    flight_date    = '20250101'
    plane_type_id  = '258-963'
    price          = '50'
    currency_code  = 'COP' )
).
*
*"---------------------------------------------------------------------------------
*" Mostrar la tabla ANTES de ordenar
*"---------------------------------------------------------------------------------
*out->write( |Before Sort| ).                                " Título/etiqueta
*out->write( lt_flights ).                                   " Contenido actual de la itab
*
*"=================================================================================
*" SORT con la clave primaria de la itab
*"=================================================================================
*SORT lt_flights.                                            " Ordena por la clave definida en lty_flights:
*                                                            " (carrier_id, connection_id, flight_date) ASC por defecto
*out->write( |Sort by primary key| ).                        " Título/etiqueta
*out->write( lt_flights ).                                   " Tabla ya ordenada por la clave
*
*"=================================================================================
*" SORT por cualquier campo (varios campos) – orden ascendente por defecto
*"=================================================================================
*SORT lt_flights BY currency_code plane_type_id.             " Ordena 1º por moneda, 2º por tipo de avión (ASC/ASC)
*out->write( |Sort by 2 fields| ).                           " Título/etiqueta
*out->write( lt_flights ).                                   " Resultado del orden múltiple
*
*"=================================================================================
*" SORT combinando ASCENDING y DESCENDING por distintos campos
*"=================================================================================
*SORT lt_flights BY carrier_id ASCENDING                     " 1º por compañía (A→Z)
*                   flight_date DESCENDING.                  " 2º por fecha (más reciente primero)
*out->write( |Sort by 2 fields (ASC/DESC)| ).                " Título/etiqueta
*out->write( lt_flights ).




"Mejor manera para eliminar registros duplicados
"Tener en cuenta que los delet solo borran los registros duplicados que se encuentren uno junto al  otro por eso tendremos que hacer una "ordenacion" con
"el sort para agrupar los campos repetidos


"En nuestro ejemplo hay 3 campos clave que tendrian que coincidir el valor de los 3 para que se hiciera el borrado de la fila/S por ello para ser mas
"especifico utilizamos el comparing + los campos que queremos comparar para borrar dichas filas.
"sino se pone el comparing solo se borran las filas con los campos repetidos si coninciden todos los campos del KEY
SORT lt_flights by carrier_id connection_id.
out->write( lt_flights ).



DELETE ADJACENT DUPLICATES FROM lt_flights  COMPARING CARRIER_ID  CONNECTION_ID.

out->write( lt_flights ).

"REDUCE
    "la expresion REDUCE en sap permite realizar acumulaciones o agrupaciones sobre elementos de una tabla interna, como sumas, restas, hacer medias etc.
    " el reduce 'reduce' todo a un unico valor.


    "sumar todas las filas de una columna de una tabla
*
*SELECT from /dmo/flight
*FIELDS *
*into table @DATA(lt_flight_red).
*
*
*"nota: si price es decimal/moneda, Reduce i "tipo entero"  truncara decimales.
*" en ese caso usa reduce decfloat34 o reduce type of ls_flight_red-price.
*
*
*
*
*DATA(lv_sum) = REDUCE i(                                "calcula la suma total (tipo entero i) de los precios
*    INIT lv_result = 0                                 "inicailiza el "acumulador"  lv_result en 0
*    for ls_flight_red in lt_flight_red                    "itera cada registro de lt_flight_red
*    next lv_result += ls_flight_red-price ).                " acumula el precio de cada vuelo en lv_result
*
*" lo mismo que arriba pero con decimales
*DATA(lv_sum2) = REDUCE decfloat34(                                "calcula la suma total (tipo entero i) de los precios
*    INIT acc = conv  decfloat34( '0.10' )                                  "inicailiza el "acumulador"  lv_result en 0
*    for ls_flight_red in lt_flight_red                    "itera cada registro de lt_flight_red
*    next acc += ls_flight_red-price ).                " acumula el precio de cada vuelo en lv_result
*
*
*out->write( 'suma de el precio de los vuelos' ).
*out->write( lv_sum2 ).

"para sumar de una tabla todos las filas de mas de una columna
    TYPES:BEGIN OF lty_total,
            price    TYPE /dmo/flight_price,
            seatsocc TYPE /dmo/plane_seats_occupied,
          END OF lty_total.

    SELECT FROM /dmo/flight
    FIELDS *
    INTO TABLE @DATA(lt_flight_red).



    DATA(lv_sum) = REDUCE lty_total(                                    "Devuelve un valor de tipo lty_total con los totales acumulados
        INIT ls_totals type lty_total                                   " acumulador inicial ( estructura con price y sseatsocc a cero por defecto)
        FOR ls_flight_red IN lt_flight_red                              "Recorre cada vuelo de la tabla lt_flight_red
        NEXT ls_totals-price  += ls_flight_red-price                    " suma el precio del vuelo al total de price
             ls_totals-seatsocc += ls_flight_red-seats_occupied ).      "suma los asientos ocupados al total de seatsocc


                                                                        "fin del reduce: el resultado se asigna a lv_sum

 ENDMETHOD.
ENDCLASS.
