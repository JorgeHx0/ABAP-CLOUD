CLASS zcl_dynamic_cache_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dynamic_cache_jpf IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.


get TIME STAMP FIELD data(lv_timestamp_begin).

select from ztab_invoice_jpf
FIELDS comp,
currency_key,
sum( amount ) as totalAmount

group by comp, currency_key
into table @data(lt_invoices).

if sy-subrc = 0.
endif.
get time STAMP FIELD data(lv_timestamp_end).

data(lv_div_sec) = cl_abap_tstmp=>subtract( exporting tstmp1 = lv_timestamp_end tstmp2 = lv_timestamp_begin ).


out->write( |numero de registros { lines( lt_invoices ) } | ).
out->write( lt_invoices ).
out->write( |tiempo de ejecución { lv_div_sec } | ).





ENDMETHOD.


ENDCLASS.
