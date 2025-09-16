"10.Parámetro opcional
"En un programa ejecutable crea la clase local ZCL_LAB_08_WORK_RECORD
"con el método público estático OPEN_NEW_RECORD que tiene cuatro
"parámetros IMPORTING:- IV_DATE de tipo ZDATE
"- IV_FIRST_NAME de tipo STRING
"- IV_LAST_NAME de tipo STRING
"- IV_SURNAME de tipo STRING
"El último parámetro IV_SURNAME es opcional y los parámetros del método
"actualizan los siguientes atributos estáticos y privados:
"- DATE de tipo ZDATE
"- FIRST_NAME de tipo STRING
"- LAST_NAME de tipo STRING
"- SURNAME de tipo STRING
"En la clase de ejecución invoca el método de la clase.



CLASS zcl_lab_08_work_record DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  .
  PUBLIC SECTION.

    CLASS-METHODS open_new_record

      IMPORTING iv_date type zde_zdate_jpf
                iv_first_name TYPE string
                iv_last_name   TYPE string
                iv_surname    TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: date       TYPE zde_zdate_jpf,
                first_name TYPE string,
                last_name  TYPE string,
                surname    TYPE string.

ENDCLASS.



CLASS zcl_lab_08_work_record IMPLEMENTATION.
  METHOD open_new_record.
  date = iv_date.
first_name = iv_first_name.
last_name = iv_last_name.
surname = iv_surname.

  ENDMETHOD.

ENDCLASS.
