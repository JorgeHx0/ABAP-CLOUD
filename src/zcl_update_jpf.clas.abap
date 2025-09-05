CLASS zcl_update_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_update_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

"...........actualización de un único campo
*data ls_airline type ztab_carrier_jpf.
*SELECT SINGLE from ztab_carrier_jpf
*FIELDS *
*where carrier_id = 'AA'
*into @ls_airline.
*
*IF sy-subrc = 0.
*out->write( |current currency: { ls_airline-currency_code }| ).
*ELSE.
*out->write( |no se ha podido insertar| ).
*
*endif.
*
*update ztab_carrier_jpf from @ls_airline.
*
*IF sy-subrc = 0.
*out->write( |el registro de ha actualizado con "currency": { ls_airline-currency_code }|  ).
*
*endif.
*
"-----------------------------------------------
"lo mismo sin haber hecho la extracción

DATA ls_airline TYPE ztab_carrier_jpf.
ls_airline = value #( carrier_id = 'AA'
name = 'American Airlines Inc.'
currency_code = 'EUR' ).
IF sy-subrc = 0.
out->write( |el registro de ha actualizado con "currency": { ls_airline-currency_code }|  ).

endif.

"-----UPDATE multiple registros

constants lc_currency type c length 3 value 'USD'.

SELECT from Ztab_carrier_jpf
FIELDS *
into table @data(lt_airlines).
if sy-subrc = 0.

loop at lt_airlines ASSIGNING FIELD-SYMBOL(<ls_airlines>).
*clear <ls_airlines>-name.
<ls_airlines>-currency_code = lc_currency.
endloop.

update ztab_carrier_jpf FROM TABLE @lt_airlines.

IF sy-subrc = 0.
out->write( |el registro de ha actualizado con "currency": { lc_currency }|  ).

endif.

endif.

ENDMETHOD.
ENDCLASS.
