CLASS zcl_delete_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_delete_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

""OJO CON LOS DELETE

select single from ztab_carrier_jpf
FIELDS *
where carrier_id = 'UA'
into @data(ls_airline).

if sy-subrc = 0.
DELETE ztab_carrier_jpf from @ls_airline.
endif.

if sy-subrc = 0.
out->write( 'El registro ha sido borrado de la base de datos' ).
endif.





ENDMETHOD.
ENDCLASS.
