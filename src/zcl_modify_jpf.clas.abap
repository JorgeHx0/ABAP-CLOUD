CLASS zcl_modify_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_modify_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

"MODIFY
"si no encuentra registro los crea----


"-----modificación de un único registro----

*data(ls_airline) = value ztab_carrier_jpf( carrier_id = 'wz'
*name = 'WIZZ AIR'
*currency_code = 'USD' ).
*
*MODIFY ztab_carrier_jpf from @ls_airline.
*
*if sy-subrc = 0.
*out->write( |el registro ha sido introducido/modificado| ).
*
*endif.

"----Medificar/actualizar múltiples registros

CONSTANTS lc_currency TYPE c LENGTH 3 VALUE 'EUR'.

    SELECT FROM ztab_carrier_jpf
       FIELDS *
          WHERE carrier_id = 'LH'
          OR carrier_id = 'AF'
          INTO TABLE @DATA(lt_airlines).

    IF sy-subrc = 0.

      LOOP AT lt_airlines ASSIGNING FIELD-SYMBOL(<fs_airline>).
        <fs_airline>-currency_code = lc_currency.
      ENDLOOP.
      APPEND VALUE #( carrier_id  = 'AV'
                      name        =  'AVIANCA'
                      currency_code = 'COP') TO lt_airlines.

      MODIFY ztab_carrier_jpf FROM TABLE @lt_airlines.

      IF sy-subrc = 0.

        out->write(  'los registros se han modificado/creado ' ).
      ELSE.
        out->write(  'los registros NO se han modificado/creado ' ).

      ENDIF.
    ELSE.
        select from /dmo/I_carrier
         FIELDS AirlineID as carrier_id,
         Name,
         CurrencyCode as currency_code
         where AirlineID = 'AF' or AirlineID = 'LH'
           into corresponding fields of table @lt_airlines.
    IF sy-subrc = 0.

        MODIFY ztab_carrier_jpf FROM TABLE @lt_airlines.

        IF sy-subrc = 0.

          out->write(  'los registros se han modificado/creado 2 ' ).
        ELSE.
          out->write(  'los registros NO se han modificado/creado  2 ' ).

        ENDIF.
      ENDIF.
    ENDIF.

     "AF,Air France,EUR



ENDMETHOD.
ENDCLASS.
