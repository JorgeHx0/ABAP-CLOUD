"7. Utilizar tipos de datos en clases
"Crea la clase ZCL_LAB_06_ELEMENTS y declara la estructura de datos
"TY_ELEM_OBJECTS con tres componentes: CLASS, INSTANCE y REFERENCE
"del tipo cadena de caracteres dinámica STRING en la sección pública. Utiliza
"la clase de ejecución para declarar una estructura global referenciada al tipo
"de datos definido en la clase. En la misma clase ZCL_LAB_06_ELEMENTS
"crea el método SET_OBJECT que actualiza el atributo MS_OBJECT que está
"referenciado al tipo definido y realiza una llamada al método desde la
"misma clase de ejecución para mostrar el contenido de la estructura
"MS_OBJECT a través de la referencia de la clase en la consola.



CLASS zcl_lab_06_elements_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_elem_objects,
             class     TYPE string,
             instance  TYPE string,
             reference TYPE string,
           END OF ty_elem_objects.


    DATA ms_object TYPE ty_elem_objects.
    METHODS set_object IMPORTING is_object TYPE ty_elem_objects.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_06_elements_jpf IMPLEMENTATION.

METHOD set_object.
    me->ms_object = is_object.

 ENDMETHOD.
ENDCLASS.
