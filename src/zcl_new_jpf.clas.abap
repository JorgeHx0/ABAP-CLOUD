CLASS zcl_new_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  "atributos públicos accesibles desde fuera de la clase
  data: lv_name type string,
        lv_age type i.

  "definición del método contructor que recibe parámetros de entrada.
        METHODS constructor importing
         iv_name type string
        iv_age type i.

INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_new_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

ENDMETHOD.

METHOD constructor.

lv_age = iv_age. "asigna el valor recibido a la variable lv_age
lv_name = iv_name. "asigna el valor recibido a la variable lv_name


Endmethod.








ENDCLASS.
