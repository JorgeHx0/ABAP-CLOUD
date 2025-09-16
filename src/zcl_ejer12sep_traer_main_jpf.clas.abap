"continuación de cl_ejer12sep_modif_main_jpf
"crea un método que devuelva una fila a partir del ID de empleado,
"o, en caso de que no exista, que devuelva la tabla entera

CLASS zcl_ejer12sep_traer_main_jpf DEFINITION


  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer12sep_traer_main_jpf IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


"creación del objeto lo_employee, pasando datos al constructor
    DATA(lo_employee) = NEW zcl_ejer12sep_traer_const_jpf(
      iv_nombre          = 'María'
      iv_apellido        =  'Gómez'
      iv_telefono        =  '333444555'
      iv_experiencia     =  5
      iv_certificaciones =  2
    ).

" llamamos a un método dentro del objeto (ver clase creadora) que se ejecuta hasta
" encontrar su ENDMETHOD, tras lo cual vuelve a esta clase después de donde lo dejó.
"almacena el returning value en lv_alta.
*  data(lv_alta) =  lo_employee->alta_empleado( ).
*
*     out->write( lv_alta ).
"-------------------------------------------------------------------------
*  lo_employee->modificar_registro( iv_nombre          = 'Jorge'
*      iv_apellido        =  'Prueba'
*      iv_telefono        =  '666999998'
*      iv_experiencia     =  5
*      iv_certificaciones =  2
*      iv_id_empleado = 2
*   ).
*
*
*data(lt_traer) = lo_employee->alta_empleado(  ).
*out->write( lt_traer ).

"--------------------------------------


DATA: lt_traer_desde_ID TYPE zcl_ejer12sep_traer_const_jpf=>tty_emp,
      lv_texto TYPE string.

      lo_employee->traer_fila_o_tabla(
      EXPORTING iv_id_empleado = 44
      IMPORTING ev_texto = lv_texto
      ev_table = lt_traer_desde_ID
      ).

out->write( lt_traer_desde_ID ).
out->write( lv_texto ).


  ENDMETHOD.

ENDCLASS.
