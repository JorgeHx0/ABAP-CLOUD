"11.Autorreferencia
"Crea la clase ZCL_LAB_09_ACCOUNT que debe contener un atributo IBAN
"de tipo STRING en la sección privada. Implementa dos métodos SET y GET
"en la sección pública para actualizar y obtener el atributo creado. El
"parámetro de entrada y salida de los métodos debe tener el mismo nombre
"IBAN. Utiliza “self reference” para apuntar al atributo de la clase. Utiliza la
"clase de ejecución para llamar a los métodos mostrando en la consola el
"valor del atributo IBAN.

CLASS zcl_lab_09_account_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS: set_iban IMPORTING iban type string,
            get_iban EXPORTING iban type string.


  PROTECTED SECTION.
  PRIVATE SECTION.
  data iban type string.
ENDCLASS.



CLASS zcl_lab_09_account_jpf IMPLEMENTATION.
  METHOD get_iban.
iban = me->iban.
  ENDMETHOD.

  METHOD set_iban.
me->iban = iban.
  ENDMETHOD.

ENDCLASS.
