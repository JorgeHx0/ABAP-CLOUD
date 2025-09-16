"Finalidad: modificar una fila en la BD.
"Partimos del ejercicio anterior zcl_ejer11sep_objetos_main_jpf.
"crear método modificar_registros
 " traer la tabla local METHODS traer_lt  RETURNING VALUE(rv_mensaje) type string.

CLASS zcl_ejer12sep_modif_main_jpf DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer12sep_modif_main_jpf IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


"creación del objeto lo_employee, pasando datos al constructor
    DATA(lo_employee) = NEW zcl_ejer12sep_modif_const_jpf(
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
  lo_employee->modificar_registro( iv_nombre          = 'Jorge'
      iv_apellido        =  'Prueba'
      iv_telefono        =  '666999998'
      iv_experiencia     =  5
      iv_certificaciones =  2
      iv_id_empleado = 2
   ).


data(lt_traer) = lo_employee->alta_empleado(  ).
out->write( lt_traer ).






*
*  )
*
*.
*
*  lo_employee->
*
*  data(lt_obj) = lo_employee->traer_lt(
*  ).
*



  ENDMETHOD.

ENDCLASS.
