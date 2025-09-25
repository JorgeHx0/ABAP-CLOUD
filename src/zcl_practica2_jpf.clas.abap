CLASS zcl_practica2_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_practica2_jpf IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

  data lv_fecha type d.
  data lv_signo type string.

  lv_fecha = '20000822'. "introducir fecha entre comillas


 if lv_fecha > '20000320' and lv_fecha < '20000420'.
 lv_signo = 'Aries'.

 elseif lv_fecha > '20000419' and lv_fecha < '20000521'.
 lv_signo = 'Tauro'.

elseif lv_fecha > '20000520' and lv_fecha < '20000621'.
 lv_signo = 'Géminis'.

 elseif lv_fecha > '20000620' and lv_fecha < '20000723'.
 lv_signo = 'Cáncer'.

  elseif lv_fecha > '20000722' and lv_fecha < '20000823'.
 lv_signo = 'Leo'.

  elseif lv_fecha > '20000822' and lv_fecha < '20000923'.
 lv_signo = 'Virgo'.

else.
lv_signo = 'error al especificar fechas'.
 endif.

out->write( lv_signo ).








  ENDMETHOD.

ENDCLASS.
