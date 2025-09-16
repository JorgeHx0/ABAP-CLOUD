CLASS zcl_15sep_class_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  METHODS constructor IMPORTING iv_employee_id type string.

  CLASS-METHODS class_constructor.

  METHODS get_employee_id RETURNING VALUE(rv_employee_id) TYPE string.

  CLASS-DATA company type string read-only.

  PROTECTED SECTION.
  PRIVATE SECTION.
  data employee_id type string.
ENDCLASS.



CLASS zcl_15sep_class_jpf IMPLEMENTATION.
  METHOD class_constructor.
zcl_15sep_class_jpf=>company = 'EXPERIS'.
  ENDMETHOD.

  METHOD constructor.
me->employee_id = iv_employee_id.
  ENDMETHOD.

  METHOD get_employee_id.
rv_employee_id = me->employee_id.
  ENDMETHOD.

ENDCLASS.
