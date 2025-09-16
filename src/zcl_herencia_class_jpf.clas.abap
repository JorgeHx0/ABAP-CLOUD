CLASS zcl_herencia_class_jpf DEFINITION
  PUBLIC
  "quitamos FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS: set_company_code IMPORTING iv_company_code type string,
            get_company_code EXPORTING ev_company_code type string,
            set_currency IMPORTING iv_currency TYPE string,
            get_currency EXPORTING ev_currency TYPE string.

 METHODS constructor IMPORTING iv_quotation type string.

 data quotation type string read-only.


  PROTECTED SECTION.
  "creamos un atributo de instancia
  data company_code type c length 4.
  data currency type c length 3.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_herencia_class_jpf IMPLEMENTATION.
  METHOD get_company_code.
ev_company_code = me->company_code.
  ENDMETHOD.

  METHOD get_currency.
ev_currency = me->currency.
  ENDMETHOD.

  METHOD set_company_code.
me->company_code = iv_company_code.
  ENDMETHOD.

  METHOD set_currency.
me->currency = iv_currency.
  ENDMETHOD.

  METHOD constructor.
me->quotation = iv_quotation.
  ENDMETHOD.

ENDCLASS.
