CLASS zcl_do_enddo_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_do_enddo_jpfb IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    DATA(lv_num) = 0.


    DO. " si escribo DO 3 times, se repetiría 3 veces.
    out->write( lv_num ).
    lv_num = lv_num + 1.
*    lv_num +=1. otra forma de incrementar una variable

if lv_num GT 8. " GT significa mayor que >
EXIT.
endif.


    ENDDO.

*****************************************

DO 20 times.
data(lv_div) = sy-index MOD 2.
* sy-index guarda el número de repeticiones que se ejecuta un bucle
* MOD resto de una división
out->write(  'hola' ).
check lv_div = 0. "afecta a las lineas hasta el ENDDO
out->write(  'hola check' ).




ENDDO.

  ENDMETHOD.

ENDCLASS.

