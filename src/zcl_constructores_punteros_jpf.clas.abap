CLASS zcl_constructores_punteros_jpf DEFINITION
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



CLASS ZCL_CONSTRUCTORES_PUNTEROS_JPF IMPLEMENTATION.


METHOD constructor.
*
Lv_age = iv_age. "asigna el valor recibido a la variable lv_age
lv_name = iv_name. "asigna el valor recibido a la variable lv_name


Endmethod.


METHOD if_oo_adt_classrun~main.



"NEW
"Se utiliza para crear instancias de clases y estructuras de manera más compacta y legible
"Con nEW puedes instanciar un objeto o estructura directamente al asignarlo a una variable,
"sin necesidad de declarar el tipo explícitamente si ya estña implícito.

"declaramos una variable de referencia a un entero (i)
data lo_data type ref to i.

"creamos un nuevo objeto de tipo entero (inferido por # ) con valor inicial 12345
lo_data = NEW #( 1234 ).

"mostramos el valor de la referencia lo_data.
out->write( lo_data ).

"declaramos y creamos una referencia a un objeto string con el valor de 'Experis'.
Data(lo_data2) = NEW string( 'Experis' ).

out->write( lo_data2 ).





ENDMETHOD.
ENDCLASS.
