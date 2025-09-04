CLASS zcl_inner_join_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_inner_join_jpf IMPLEMENTATION.



METHOD if_oo_adt_classrun~main.

"con la tabla /dmo/connection y /DMO/flight, saca lista de vuelos
" con ruta origen ->destino, fecha y precio en un rango
"de fechas (el rango lo elegís vosotros)
"agregacion por ruta : numero de vuelos y precio minimo y maximo

"filtrar rutas donde el precio minimo > 300


data: lv_fecha_min type DATN,
 lv_fecha_max type DATN.

"fijando filtros
lv_fecha_min = '20200101'.
lv_fecha_max = '20270101'.
data(lv_precio_min) = 1000.
data(lv_precio_max) = 9000.

"transformando fechas
data(lv_fecha_min_separada) = |{ lv_fecha_min+0(4) }-{ lv_fecha_min+4(2) }-{ lv_fecha_min+6(2) }|.
data(lv_fecha_max_separada) = |{ lv_fecha_max+0(4) }-{ lv_fecha_max+4(2) }-{ lv_fecha_max+6(2) }|.


SELECT
 FROM /dmo/connection
INNER JOIN /DMO/flight
on /dmo/connection~connection_id = /dmo/flight~connection_id
fields
/dmo/flight~carrier_id,
/dmo/flight~connection_id,
 airport_from_id,
 airport_to_id, flight_date,
 price,
currency_code
where PRICE < @lv_precio_max
AND PRICE > @lv_precio_min
AND FLIGHT_DATE < @lv_fecha_max
AND FLIGHT_DATE > @lv_fecha_min

into table @data(lt_join).

SELECT
FROM /dmo/airport
fields *
into table @data(lt_aeropuertos).

types: begin of ty_conjunta,
       carrier type /dmo/carrier_id,
       connection type /dmo/connection_id,
       city_from type /dmo/city,
       city_to type /dmo/city,
       flight_date type /dmo/flight_date,
       price type /dmo/flight_price,
       currency type /dmo/currency_code,
       end of ty_conjunta.

data lt_conjunta type table of ty_conjunta WITH NON-UNIQUE KEY connection.

lt_conjunta = VALUE #( FOR ls_join IN lt_join
                        FOR ls_aeropuertos IN lt_aeropuertos WHERE ( airport_id = ls_join-airport_from_id )
                        FOR ls_aeropuertos2 IN lt_aeropuertos WHERE ( airport_id = ls_join-airport_to_id )
                        ( carrier = ls_join-carrier_id
                        connection = ls_join-connection_id
                        city_from = ls_aeropuertos-city
                        city_to = ls_aeropuertos2-city
                        flight_date = ls_join-flight_date
                        price = ls_join-price
                        currency = ls_join-currency_code ) ).

out->write( 'TABLA FILTRADA' ).
out->write( '-----------------------' ).
out->write( |Fecha desde { lv_fecha_min_separada } hasta { lv_fecha_max_separada }.| ).
out->write( |Precio desde { lv_precio_min } hasta { lv_precio_max }.| ).
out->write( '-----------------------' ).
out->write( lt_conjunta ).


"tabla con recuento con vuelos con mismo ID

types: begin of ty_resumen,
       carrier type /dmo/carrier_id,
       connection type /dmo/connection_id,
       city_from type /dmo/city,
       city_to type /dmo/city,
       currency type /dmo/currency_code,
       flight_date type /dmo/flight_date,
       flights type i,
       min_price type /dmo/flight_price,
       max_price type /dmo/flight_price,
 end of ty_resumen.



data lt_mapeo type table of ty_resumen WITH NON-UNIQUE KEY connection.
data ls_mapeo TYPE ty_resumen.

loop at lt_conjunta ASSIGNING FIELD-SYMBOL(<gfs_mapeo>).
ls_mapeo-carrier = <gfs_mapeo>-carrier.
ls_mapeo-connection = <gfs_mapeo>-connection.
ls_mapeo-city_from = <gfs_mapeo>-city_from.
ls_mapeo-city_to = <gfs_mapeo>-city_to.
ls_mapeo-currency = <gfs_mapeo>-currency.
ls_mapeo-min_price = <gfs_mapeo>-price.
ls_mapeo-max_price = <gfs_mapeo>-price.
append ls_mapeo to lt_mapeo.
endloop.

out->write( lt_mapeo ).


*
*data lt_ordenar type table of ty_resumen WITH NON-UNIQUE KEY connection.
*
*data ls_ordenar TYPE ty_resumen.
*
*
*data lv_contador type i value 0.
*
*
*
*loop at lt_conjunta ASSIGNING FIELD-SYMBOL(<fs_1>).
*loop at lt_conjunta ASSIGNING FIELD-SYMBOL(<fs_2>).
*
*if <fs_1> EQ <fs_2>.
*lv_contador = lv_contador + 1.
*
*ls_ordenar-carrier = <fs_1>-carrier.
*ls_ordenar-connection = <fs_1>-connection.
*ls_ordenar-city_from = <fs_1>-city_from.
*ls_ordenar-city_to = <fs_1>-city_to.
*ls_ordenar-currency = <fs_1>-currency.
*ls_ordenar-min_price = <fs_1>-min_price.
*ls_ordenar-max_price = <fs_1>-max_price.
*
*APPEND <fs_1> to lt_ordenar.
*
*IF
*endif.
*
*endloop.
*
*ls_resumen-carrier = <fs_1>-carrier.
*ls_resumen-connection = <fs_1>-connection.
*ls_resumen-city_from = <fs_1>-city_from.
*ls_resumen-city_to = <fs_1>-city_to.
*ls_resumen-currency = <fs_1>-currency.
*ls_resumen-min_price = <fs_1>-price.
*ls_resumen-max_price = <fs_1>-price.




ENDMETHOD.
ENDCLASS.
