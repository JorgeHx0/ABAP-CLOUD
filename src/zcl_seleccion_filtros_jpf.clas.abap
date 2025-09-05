CLASS zcl_seleccion_filtros_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_seleccion_filtros_jpf IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.
"-------------- operadores relacionales binarios----------------
    " = EQ ----> igual
    " <> NE ---> distinto
    " < LT ----> menor que
    " > GT ----> Great than
    " <= LE ---> lees equal
    " >= GE ---> Great equal

*    SELECT FROM ztab_flight_der
*       FIELDS *
*       WHERE flightdate > '20260415'
*       INTO TABLE @DATA(lt_flights).
*
*
*    IF sy-subrc = 0.
*      out->write( lt_flights ).
*    ENDIF.

    "------------------  Between --------------


*    SELECT FROM ztab_flight_der
*       FIELDS *
*       WHERE flightdate  ge  '20250619'  and  flightdate le '20260415'
*       INTO TABLE @DATA(lt_flights).
*
*SELECT FROM ztab_flight_der
*       FIELDS *
*       WHERE flightdate  not BETWEEN '20250619' and  '20260415'
*       INTO TABLE @DATA(lt_flights).
*
*
*    IF sy-subrc = 0.
*      out->write( lt_flights ).
*    ENDIF.
*
    "-------- in ----------------------

*
*    SELECT FROM ztab_flight_der
*  FIELDS *
*  WHERE airlineid IN ( 'AA', 'AZ' , 'JL' )
*  INTO TABLE @DATA(lt_airlines).
*
*    IF sy-subrc = 0.
*      out->write( lt_airlines ).
*    ENDIF.
    "-------------- in con tablas de rangos----------------


    DATA lr_price TYPE RANGE OF /dmo/price.

    lr_price = VALUE #( ( sign = 'I'
                            option = 'BT'
                            low   = 500
                            high  = 1500 ) ).


    APPEND VALUE #( sign = 'I'
                       option = 'EQ'
                       low = '4996.00' ) TO lr_price.


    SELECT FROM ztab_flight_JPF
     FIELDS *
     WHERE price IN @lr_price
         AND currencycode = 'USD'
         INTO TABLE @DATA(lt_flights).

    IF sy-subrc = 0.
      out->write( lt_flights ).
    ENDIF.

ENDMETHOD.
ENDCLASS.
