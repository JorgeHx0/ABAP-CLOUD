"introducimos por separado mes y día como enteros i
"se obtiene variable tipo fecha d  empezando con año genérico bisiesto

CLASS zcl_practica1_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_practica1_jpf IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA:lv_mes TYPE i,
         lv_dia TYPE i.

    lv_mes = 30.
    lv_dia = 12.

    "transformar mes a cadena
    DATA lv_mes_string TYPE string.
    lv_mes_string = CONV string( lv_mes ).

    "si el mes tiene una cifra, se añade un 0 delante
    IF lv_mes < 10.
      DATA lv_cero TYPE string VALUE '0'.
      CONCATENATE lv_cero lv_mes_string  INTO lv_mes_string .
    ENDIF.

    CONDENSE lv_mes_string. "elimina posibles caracteres en blanco

    "transformar día a cadena
    DATA lv_dia_string TYPE string.
    lv_dia_string = CONV string( lv_dia ).

    "si el dia tiene una cifra, se añade un 0 delante
    IF lv_dia < 10.
      CONCATENATE lv_cero lv_dia_string  INTO lv_dia_string .
    ENDIF.

    CONDENSE lv_dia_string.

    "concatenar año 2000 (bisiesto) con mes y día
    DATA: lv_fecha_concat_texto TYPE string,
          lv_generic_leap_year  TYPE string VALUE '2000'.

    lv_fecha_concat_texto = |{ lv_generic_leap_year }{ lv_mes_string }{ lv_dia_string }|.

    "transformar la cadena a fecha
    DATA(lv_fecha) = CONV d( lv_fecha_concat_texto ).
    out->write( lv_fecha ).

  ENDMETHOD.

ENDCLASS.
