"3. Encapsulación
"Crea la clase ZCL_LAB_03_CONTRACT con los siguientes componentes en
"cada sección de encapsulación: pública, protegida y privada:
"1. Sección pública
"Atributo: CNTR_TYPE – de tipo carácter de dos posiciones.
"Método: SET_CREATION_DATE. Utiliza un parámetro IMPORTING
"(IV_CREATION_DATE) para establecer el valor del atributo
"CREATION_DATE.
"2. Sección protegida
"Atributo: CREATION_DATE de tipo ZDATE.
"3. Sección privada
"Atributo: CLIENT de tipo cadena de caracteres dinámica STRING.



CLASS zcl_lab_03_contract_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  "atributo
data lv_cnty_type type c length 2.

  "declaración de método/función de instancia
METHODS set_creation_date IMPORTING iv_creation_date type zde_zdate_jpf
EXPORTING creation_date type zde_zdate_jpf.

  PROTECTED SECTION.

  "atributo
data creation_date type zde_zdate_jpf.

  PRIVATE SECTION.

  "atributo
data client type string.

ENDCLASS.



CLASS zcl_lab_03_contract_jpf IMPLEMENTATION.

  METHOD set_creation_date.
me->creation_date = iv_creation_date.

  ENDMETHOD.

ENDCLASS.
