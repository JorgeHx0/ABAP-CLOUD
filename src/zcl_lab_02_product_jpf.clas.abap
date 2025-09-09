"2. Creación de clases
"Comprueba si en la instancia ABAP, del entorno Cloud del BTP, si existe el
"elemento de datos ZDATE. Si no existe, en el paquete de desarrollo crea el
"elemento de datos ZDATE que es de tipo DATS.
"Continua con la creación de una clase ABAP con el nombre
"ZCL_LAB_02_PRODUCT con dos atributos de instancia en la encapsulación
"privada llamados:
"- PRODUCT de tipo MATNR
"- CREATION_DATE de tipo ZDATE
"y dos métodos llamados SET_PRODUCT y SET_CREATIONDATE en la
"encapsulación pública. Cada método debe tener un parámetro de entrada
"que actualiza los atributos PRODUCT y CCREATION_DATE.



CLASS zcl_lab_02_product_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

"declaración de método
    METHODS set_product IMPORTING iv_product TYPE matnr.

    METHODS create_date IMPORTING iv_creation_date TYPE zde_zdate_jpf.

  PROTECTED SECTION.
  PRIVATE SECTION.

    "atributos
    DATA: product       TYPE matnr,
          creation_date TYPE zde_zdate_jpf.

ENDCLASS.



CLASS zcl_lab_02_product_jpf IMPLEMENTATION.

  METHOD create_date. "implementación de los métodos:
    me->creation_date = iv_creation_date.
    "el atributo creation_date recoge lo que se ha importado con iv_creation_date

  ENDMETHOD.

  METHOD set_product.
    me->product = iv_product.

  ENDMETHOD.

ENDCLASS.
