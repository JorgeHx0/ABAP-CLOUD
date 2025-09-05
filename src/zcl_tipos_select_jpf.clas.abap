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

select from ztab_flight_jpf
FIELDS *
WHERE airlineid = 'LH'
INTO TABLE @data(lt_flights)
up to 3 rows.

if sy-subrc = 0.
out->write( lt_flights ).
endif.

ENDMETHOD.
ENDCLASS.
