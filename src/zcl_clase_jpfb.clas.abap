CLASS zcl_clase_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CLASE_JPFB IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

out->write( 'hola mundoooo'  ). "esta linea imprime por consola"

ENDMETHOD.
ENDCLASS.
