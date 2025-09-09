CLASS zcl_tipos_select_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tipos_select_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.
"--------Select single
*    SELECT SINGLE FROM ztab_carrier_der
*        FIELDS *
*        WHERE carrier_id = 'AA'
*        INTO @DATA(ls_airline).
*
*    IF sy-subrc = 0.
*        out->write( ls_airline ).
*    ENDIF.

    "----------------- select into  y appending table ---------------------

*    DATA lt_airlines TYPE STANDARD TABLE OF ztab_carrier_der.
*
*    SELECT FROM ztab_carrier_der
*        FIELDS *
*            WHERE currency_code = 'USD'
*            INTO TABLE @lt_airlines.
*
*    IF sy-subrc = 0.
*      out->write( lt_airlines ).
*    ENDIF.
*
*    out->write( 'nueva seleccion' ).
*
*    SELECT FROM ztab_carrier_der
*        FIELDS *
*          WHERE currency_code = 'XYZ'
*          INTO TABLE @lt_airlines.
*
*    out->write( lt_airlines ).
*
*    if lt_airlines is initial.
*
*        out->write( 'no hay datos en la tabla interna' ).
*     endif.

    "----- appending table

*    DATA lt_airlines TYPE STANDARD TABLE OF ztab_carrier_der.
*
*    SELECT FROM ztab_carrier_der
*        FIELDS *
*            WHERE currency_code = 'USD'
*            INTO TABLE @lt_airlines.
*
*    IF sy-subrc = 0.
*
*  "    APPEND INITIAL LINE TO lt_airlines.
*
*
*      SELECT FROM ztab_carrier_der
*          FIELDS *
*            WHERE currency_code = 'EUR'
*            APPENDING TABLE @lt_airlines.
*
*         out->write( lt_airlines ).
*
*    ENDIF.

"select into corresponding fields
*
*TYPES: begin of ty_flights,
*       airlineid type c LENGTH 3,
*       connectionid type n LENGTH 4,
*       price type p length 16 decimals 2,
*       currencycode type c length 5,
*       end of ty_flights.
*
*data lt_flights type STANDARD TABLE OF ty_flights.
*
*select from ztab_flight_jpf
*FIELDS *
*where airlineid = 'LH'
*INTO CORRESPONDING FIELDS OF TABLE @lt_flights.
*
*if sy-subrc = 0.
*out->write( lt_flights ).
*
*endif.

"-----------select columns----

select single from ztab_flight_jpf
fields price
where airlineid = 'AA'
and connectionid = '0018'
and flightdate = '20250620'
into @data(lv_flight_price).

if sy-subrc = 0.
out->write( lv_flight_price ).
endif.

"----------select up to n rows

*select from ztab_flight_jpf
*FIELDS *
*WHERE airlineid = 'LH'
*INTO TABLE @data(lt_flights)
*up to 3 rows.
*
*if sy-subrc = 0.
*out->write( lt_flights ).
*endif.

"--------select package size
data lt_flights type SORTED TABLE OF ztab_flight_jpf
WITH NON-UNIQUE key airlineid connectionid.

SELECT from ztab_flight_jpf
FIELDS *
into table @lt_flights
PACKAGE SIZE 4.

loop at lt_flights ASSIGNING FIELD-SYMBOL(<ls_flights>).
out->write(  | { <ls_flights>-airlineid  } { <ls_flights>-connectionid  } | ).
endloop.

out->write( cl_abap_char_utilities=>newline ).


"---------------MIN MAX----------------------------------------


*select from /dmo/I_Flight
*    FIELDS min( MaximumSeats ) as MinSeats,
*           max( MaximumSeats ) as MaxSeats
*    into ( @data(lv_min_seats), @data(lv_max_seats) ).
*
*
*if sy-subrc = 0.
*
*    out->write( |Min Seats: { lv_min_seats }; Max Seats { lv_max_seats } | ).
*endif.
*
*
*select from /dmo/I_Flight
*    FIELDS min( MaximumSeats ) as MinSeats,
*           max( MaximumSeats ) as MaxSeats
*    into @data(ls_min_max).
*
*
*if sy-subrc = 0.
*
*    out->write( ls_min_max ).
*endif.

    "-------------------------- AVG / SUM ---------------------------------
*
*    SELECT FROM /dmo/I_Flight
*        FIELDS SUM( MaximumSeats ) AS SumSeats,
*               AVG( MaximumSeats ) AS AvgSeats
*          INTO  @DATA(ls_avg_sum_seats).
*
*
*    IF sy-subrc = 0.
*
*      out->write( ls_avg_sum_seats  ).
*    ENDIF.

    "----------------------- Distinc----------------------------

    "Eliminar campos repetidos

    "------------------------ Count----------------------------------

*    SELECT FROM /dmo/I_flight
*        FIELDS COUNT( * ) AS CountAll,
*                COUNT( DISTINCT MaximumSeats ) AS CountMaximumSeats
*        WHERE AirlineID = 'AA'
*        INTO ( @DATA(lv_count_all), @DATA(lv_distinct_seats) ).
*
*
*    IF sy-subrc = 0.
*
*      out->write( |Count all { lv_count_all }; Count distinct seats { lv_distinct_seats }| ).
*    ENDIF.

    "------------------------ Group by ------------------------------------------------

*    SELECT FROM /dmo/i_flight
*        FIELDS AirlineID,
*            COUNT( DISTINCT ConnectionID ) AS CountDistinctConn
*         WHERE FlightDate = '20250621'
*         GROUP BY AirlineID
*         INTO TABLE @DATA(lt_results).
*
*  IF sy-subrc = 0.
*     out->write( lt_results ).
*    ENDIF.


    "------------------------- order by y having  ---------------------------------------------------
    " where filtra filas antes del group by; having filtra despues usando agregados

*    SELECT FROM /Dmo/I_flight
*        FIELDS AirlineID,
*            MIN( MaximumSeats ) AS MinSeats,
*            MAX( MaximumSeats ) AS MaxSeats
*        where FlightDate BETWEEN '20250617' and '20260419'
*        GROUP BY AirlineID having AirlineID in ( 'AA', 'LH', 'UA' )
*        ORDER BY AirlineID DESCENDING
*        into table @data(lt_results).
*
*     IF sy-subrc = 0.
*     out->write( lt_results ).
*   ENDIF.

    "-------------------------- offset----------------------------------------------------------------------

    " desplazamiento del resultado
    " Salta las primeras  "N" numero de filas y devuelve el resto o el siguente bloque

*    DATA: lv_page_number      TYPE i VALUE 1,
*          lv_records_per_page TYPE i VALUE 10.
*
*    DATA gv_offset TYPE  int8.
*
*
*    gv_offset = ( lv_page_number - 1 ) * lv_records_per_page.
*
*    SELECT FROM /dmo/I_Flight
*        FIELDS *
* "      WHERE CurrencyCode = 'USD'
*        ORDER BY AirlineID, ConnectionID, FlightDate ASCENDING
*        INTO TABLE @DATA(lt_results)
*        OFFSET @gv_offset
*        UP TO @lv_records_per_page ROWS.
*
*
*    IF sy-subrc = 0.
*      out->write( lt_results ).
*    ELSE.
*      out->write( 'No hay columnas disponibles para la siguiente pagina' ).
*    ENDIF.
ENDSELECT.

ENDMETHOD.
ENDCLASS.
