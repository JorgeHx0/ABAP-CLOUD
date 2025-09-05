CLASS zcl_insert_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

*
*data ls_airline TYPE ztab_carrier_jpf.
*ls_airline = value #( carrier_id = 'AA'
*name = 'American Airlines'
*currency_code = 'USD' ).
*
*
* "forma no recomendada
* "INSERT INTO ztab_carrier_jpf values @ls_airline
*
* "forma recomendada
* INSERT ztab_carrier_jpf from @ls_airline.
*
*"comprobamos si se introdujo correctamente
*if sy-subrc = 0.
*out->write( 'registro introducido correctamente' ).
*else.
*out->write( 'registro NO introducido' ).
*endif.

"--------------inserción de múltiples registros---------------

DELETE from ztab_carrier_jpf. "borra el contenido de la tabla. Cuidado al usar DELETE.

DATA lt_dddd TYPE STANDARD TABLE OF ztab_carrier_jpf.

SELECT from /dmo/I_Carrier
FIELDS *
WHERE currencycode = 'USD'
INTO TABLE @data(lt_airlines).

if sy-subrc = 0.
lt_dddd = CORRESPONDING #( lt_airlines mapping carrier_id = AirlineID ).
"mapeo si porque nombre del componente en I_Carrier es distinto que en lt_airlines

insert ztab_carrier_jpf from table @lt_dddd.
if sy-subrc = 0.
out->write( |El número de lineas insertadas es: { sy-dbcnt }| ).
endif.

endif.


"otra forma de hacerlo

*DELETE FROM ztab_carrier_jpf.
*
*    DATA lt_ddbb TYPE STANDARD TABLE OF ztab_carrier_jpf.
*
*    SELECT FROM /dmo/I_Carrier
*    FIELDS AirlineID AS carrier_id,
*           name,
*           CurrencyCode AS currency_code
*    WHERE CurrencyCode = 'USD'
*    INTO CORRESPONDING FIELDS OF TABLE @lt_ddbb.
*
*    IF sy-subrc = 0.
*
*    try.
*
*      INSERT ztab_carrier_jpf FROM TABLE @lt_ddbb.
*
*      catch cx_sy_open_sql_db into data(lx_sql_db).
*      out->write( lx_sql_db->get_text(  ) ). "para que nos de el texto describiendo el error.
*      return.
*      endtry.
*
*      IF sy-subrc = 0.
*        out->write( |El numero de lineas insertadas es: { sy-dbcnt }| ).
*        ELSE.
*        out->write( |la inserción no se ha ejecutado correctamente | ).
*      ENDIF.
*
*    ENDIF.


"-----------------
data lt_flight type standard table of /dmo/i_carrier.


"""----mal
"select
"from /dmo/i_carrier
"fields *
"into table @lt_flight.
"INSERT ztab_flight_jpf from table @lt_flight.
"----mal



DATA lt_flights TYPE STANDARD TABLE OF ztab_flight_jpf.

    SELECT FROM /DMO/I_Flight
     FIELDS *
     INTO CORRESPONDING FIELDS OF TABLE @lt_flights.

    IF sy-subrc = 0.
      INSERT ztab_flight_jpf FROM TABLE @lt_flights.
      IF sy-subrc = 0.
        out->write( |Insercciones: { sy-dbcnt } filas | ).
      ENDIF.
    ENDIF.

*select
*from /dmo/i_carrier
*fields *
*into table @data(lt_flight).
*INTO CORRESPONDING FIELDS OF TABLE @lt_flight.

ENDMETHOD.

ENDCLASS.
