CLASS zcl_00_main_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_00_main_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

data(lo_employee) = NEW zcl_01_class_jpf( iv_employee_id = '01' ).

ENDMETHOD.

ENDCLASS.
