CLASS zcl_lab_04_person_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    data var type string value 'hola'.
    METHODS set_age IMPORTING iv_age TYPE i.
    METHODS get_age EXPORTING ev_age TYPE i.


  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA lv_age TYPE i.

ENDCLASS.



CLASS zcl_lab_04_person_jpf IMPLEMENTATION.


  METHOD set_age.
    me->lv_age = iv_age.

  ENDMETHOD.

  METHOD get_age.
    ev_age = me->lv_age.

  ENDMETHOD.



ENDCLASS.
