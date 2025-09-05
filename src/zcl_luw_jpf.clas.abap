CLASS zcl_luw_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_luw_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

update ztab_carrier_jpf
set currency_code = 'EUR'
WHERE carrier_id = 'AA'.

if sy-subrc = 0.
select SINGLE from ztab_carrier_jpf
FIELDS *
where carrier_id = 'AA'
INTO @data(ls_airline).

if sy-subrc = 0.
out->write( ls_airline-currency_code ).
endif.

endif.

rollback work.







ENDMETHOD.


ENDCLASS.
