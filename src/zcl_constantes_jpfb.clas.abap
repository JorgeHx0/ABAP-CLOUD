CLASS zcl_constantes_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_constantes_jpfb IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*CONSTANTS:lc_país TYPE string VALUE 'España',
*          lc_moneda TYPE string VALUE 'EUR',
*          lc_iva TYPE P DECIMALS 2 VALUE '21.00'.
*          lc_pi type p LENGTH 3 DECIMALS 2 VALUE '3.14'.


*cálculo del área de un círculo

    CONSTANTS: lc_pi TYPE p LENGTH 3 DECIMALS 2 VALUE '3.14'.
    DATA: lv_radio TYPE p DECIMALS 5 VALUE 100.
    DATA: Lv_area TYPE p LENGTH 10 DECIMALS 2.
    lv_area =  lc_pi * lv_radio ** 2.

    out->write( lv_area  ).



  ENDMETHOD.


ENDCLASS.
