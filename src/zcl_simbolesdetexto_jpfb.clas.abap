CLASS zcl_simbolesdetexto_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SIMBOLESDETEXTO_JPFB IMPLEMENTATION.


METHOD if_oo_adt_classrun~main. """""

out->write(  TEXT-001 ).
out->write( 'Mi primer símbolo de texto'(001) ).


  ENDMETHOD.
ENDCLASS.
