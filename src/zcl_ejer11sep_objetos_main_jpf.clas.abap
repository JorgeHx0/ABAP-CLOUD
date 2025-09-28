"Finalidad: añadir una fila en la BD combinando unos datos dados con otros
"generados a partir de estos. Se muestra por consola mensaje de confirmación o error.

"se crea un objeto construido en la clase zcl_ejer11sep_objetos_constjpf.
"Se invoca el método alta_empleado, que a su vez invoca a otros dos métodos.

CLASS zcl_ejer11sep_objetos_main_jpf DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer11sep_objetos_main_jpf IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

"creación del objeto lo_employee, pasando datos al constructor
    DATA(lo_employee) = NEW zcl_ejer11sep_objetos_constjpf(
      iv_nombre          = 'María'
      iv_apellido        =  'Gómez'
      iv_telefono        =  '666123123'
      iv_experiencia     =  5
      iv_certificaciones =  2
    ).

" llamamos a un método dentro del objeto (ver clase creadora) que se ejecuta hasta
" encontrar su ENDMETHOD, tras lo cual vuelve a esta clase después de donde lo dejó.
"almacena el returning value en lv_alta.
  data(lv_alta) =  lo_employee->alta_empleado( ).

     out->write( lv_alta ).

  ENDMETHOD.

ENDCLASS.
