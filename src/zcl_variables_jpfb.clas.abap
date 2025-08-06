CLASS zcl_variables_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_variables_jpfb IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
*
*    DATA: lv_string TYPE string VALUE 'hola',
*          lv_date   TYPE d,
*          lv_time   TYPE t,
*          lv_time2  TYPE t,
*          lv_int    TYPE i VALUE 35,
*          lv_dec    TYPE p LENGTH 8 DECIMALS 2 VALUE '325.45'. "declaramos una variable tipo alfanumérico. si es decimal hay que ponerlo entre comillas simples
*
*    DATA: lv_nombre     TYPE string,
*          lv_edad       TYPE i,
*          lv_dni        TYPE string,
*          lv_nacimiento TYPE d.
*
*    lv_date = cl_abap_context_info=>get_system_date(  ). "fecha actual del ordenador
*    lv_time = cl_abap_context_info=>get_system_time(  ).
*    lv_time2 = cl_abap_context_info=>get_user_time_zone( ).
*
*    out->write( lv_string  ).
*    out->write( 'lv_string'  ).
*
*    out->write( | Nombre = { lv_string } Edad = { lv_int  } Fecha {  lv_date  } hora actual = { lv_time } hora actual  {  lv_time2 } | ).


*para comentar varias líneas se seleccionan
*y control+7


    "operaciones matemáticas con variables
    "1 suma

    DATA: lv_num1 TYPE i VALUE 2,
          lv_num2 TYPE i VALUE 3,
          lv_res  TYPE i.

    lv_res = lv_num1 + lv_num2.

    out->write( | la suma de { lv_num1 } y { lv_num2 } es { lv_res } | ).



    "resta
    lv_res = lv_num1 - lv_num2.
    out->write( |  { lv_num1 } - { lv_num2 } = { lv_res } | ).


    "multiplicación
    lv_res = lv_num1 * lv_num2.
    out->write( |  { lv_num1 } * { lv_num2 } = { lv_res } | ).


    "división

    DATA: lv_res_div TYPE p LENGTH 3 DECIMALS 4.

    lv_res_div = lv_num1 / lv_num2.

    out->write( |  { lv_num1 } / { lv_num2 } = { lv_res_div } | ).


    DATA: lv_date  TYPE d,
          lv_date2 TYPE d VALUE '20240623 ',
          lv_mes   TYPE string.

*    lv_date = cl_abap_context_info=>get_system_date(  ).
*
*    lv_mes = lv_date2+4(2). " mes
*     out->write( lv_mes ).
*    lv_mes = lv_date2(4).
*     out->write( lv_mes ).
*    lv_mes = lv_date2+3.
*     out->write( lv_mes ).


*cuenta cadena
*
*    DATA: lv_cadena   TYPE string VALUE 'hola tengo sueño',
*          lv_contador TYPE i.
*
*    lv_contador = numofchar(  lv_cadena  )."cuenta cadena
*
*    out->write( lv_contador ).

*contar cuantas veces aparece una cadena de caracteres. distingue entre mayúsculas y minúsculas
    DATA: lv_cadena   TYPE string VALUE 'DANIEL daniel',
          lv_contador TYPE i.

lv_contador = count( val = lv_cadena sub = 'DA' ).

       out->write( lv_contador ).


*declaración de variables en línea

DATA(lv_variable_linea) = 8 * 16.   "el programa reconoce aunomáticamente el tipo. en este caso es numérico.
out->write( lv_variable_linea ).

DATA(lv_div) = 8 / 16. " ejemplo de declaración en línea que causa problemas, porque redondea a 1 al haberse creado la variable de tipo i
out->write( lv_div ).

DATA(lv_text) = 'ABAP I - 2025'.
out->write(  lv_text ).

DATA(lv_dec) = '10.245'.
out->write( lv_dec ). "también da problemas

  ENDMETHOD.

ENDCLASS.


