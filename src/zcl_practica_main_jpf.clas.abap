CLASS zcl_practica_main_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_practica_main_jpf IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lv_nombre TYPE string,
          lv_mes    TYPE i,
          lv_dia    TYPE i.

    "---------------------------------------------
    "EL BRUJO DE ABAP
    lv_nombre = 'Jorge'. "Introduzca su nombre entre comillas
    lv_dia = 16. "introduzca día de nacimiento
    lv_mes = 09. "introduzca mes de nacimiento
    "mucha suerte jojojoj...
    "-----------------------------------------------

    "-------------------------------
    DATA lo_instance TYPE REF TO zcl_practica_fabrica_jpf.
    lo_instance = NEW zcl_practica_fabrica_jpf( iv_mes = lv_mes iv_dia = lv_dia ).

    DATA(ls_prediccion) = lo_instance->prediction( ).
    DATA(lv_error_fecha_flag) = lo_instance->fecha( ).

    IF lv_error_fecha_flag EQ 0.

      out->write( |*Horóscopo personalizado para { lv_nombre }* | ).
      out->write( |---------------------------------------------------- | ).
      out->write( |Cumpleaños: { lv_dia }-{ lv_mes }. Signo: { ls_prediccion-signo } | ).
      out->write( |\n| ).
      out->write( |Salud: { ls_prediccion-salud } | ).
      out->write( |Dinero: { ls_prediccion-dinero } | ).
      out->write( |Amor: { ls_prediccion-amor } | ).
      out->write( |Familia: { ls_prediccion-familia } | ).
      out->write( |Amistades: { ls_prediccion-amistades } | ).
      out->write( |\n| ).
      out->write( |prueba mañana para un resultado distinto! | ).

    ELSE.
      out->write( 'La fecha proporcionada es incorrecta.' ).

    ENDIF.


  ENDMETHOD.
ENDCLASS.
