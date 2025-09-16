CLASS zcl_15sep_main_jpf DEFINITION



  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_15sep_main_jpf IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


*"creación del objeto lo_employee, pasando datos al constructor
*    DATA(lo_employee) = NEW zcl_ejer12sep_traer_const_jpf(
*      iv_nombre          = 'María'
*      iv_apellido        =  'Gómez'
*      iv_telefono        =  '333444555'
*      iv_experiencia     =  5
*      iv_certificaciones =  2
*    ).

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


*DATA: lt_traer_desde_ID TYPE zcl_ejer12sep_traer_const_jpf=>tty_emp,
*      lv_texto TYPE string.
*
*      lo_employee->traer_fila_o_tabla(
*      EXPORTING iv_id_empleado = 44
*      IMPORTING ev_texto = lv_texto
*      ev_table = lt_traer_desde_ID
*      ).
*
*out->write( lt_traer_desde_ID ).
*out->write( lv_texto ).


*
*data(lo_employee1) = zcl_15sep_class_jpf( iv_employee_id = '01' ).
*
*out->write( lo_employee1->get_employee_id(  ) ).
*
*data(lo_employee1) = zcl_15sep_class_jpf( iv_employee_id = '02' ).

"constructor estático
data(lo_employee1) = new zcl_15sep_class_jpf( iv_employee_id = '01' ).
out->write( lo_employee1->get_employee_id(  ) ).


data(lo_employee2) = new zcl_15sep_class_jpf( iv_employee_id = '02' ).

out->write( lo_employee2->get_employee_id(  ) ).


out->write( zcl_15sep_class_jpf=>company ).

"--HERENCIA

"comprobamos ue al hacer referencia a las clases hija y nieta
*data(lo_company) = new zcl_herencia_class_jpf( iv_quotation = 'q1' ).
*data(lo_pant) = NEW zcl_herencia2_class_jpf( iv_quotation = 'q2' ).
*DATA(lo_storage_location) = NEW zcl_herencia3_class_jpf( iv_quotation = 'q3' ).
*
*LO_pant->set_company_code( '1234' ).
*lo_company->set_currency( 'USD' ).
*
*lo_pant->get_company_code( importing ev_company_code = data(lv_company_code) ).
*lo_pant->get_currency( importing ev_currency = data(lv_currency) ).
*
*out->write( |{ lv_company_code }-{ lv_currency }| ).
"---------------------------------------------------------

"---NARROWING CAST-----

data(lo_animal) = NEW zcl_06_animal_jpf(  ).
data(lo_leon) = NEW zcl_07_leon_jpf(  ).

*out->write( lo_animal->walk(  ) ).
*out->write( lo_leon->walk(  ) ).
*lo_animal = lo_leon.
*
* out->write( 'narrowing cast' ).
* out->write( lo_leon->walk(  ) ).

"si pusiera al león primero: widening casting (down cast)
try.
lo_leon ?= lo_animal.
catch cx_sy_move_cast_error.
out->write( 'casting error' ).
return.
endtry.




  ENDMETHOD.


ENDCLASS.
