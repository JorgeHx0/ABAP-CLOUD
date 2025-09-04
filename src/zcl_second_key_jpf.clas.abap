CLASS zcl_second_key_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_second_key_jpf IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

*Data: gt_employees type SORTED TABLE OF ztab_jorge2_jpf with UNIQUE key id
*           with NON-UNIQUE SORTED KEY first_name
*           COMPONENTS last_name.

*select
*from ztab_jorge2_jpf
*fields *
*into table @gt_employees.



*    loop at gt_employees_dd ASSIGNING FIELD-SYMBOL(<gs_employees>) where id between  '00000002' and  '00000005'.
*
*
*   out->write( <gs_employees> ).
*
*
*    endloop.

*    out->write( gt_employees ).


DATA gt_employees_dd TYPE ztt_secundaria_jpf.

SELECT *
  FROM ztab_employ2_jpf
  INTO CORRESPONDING FIELDS OF TABLE @gt_employees_dd.

    loop at gt_employees_dd ASSIGNING FIELD-SYMBOL(<gs_employees>) where employee_id between  '00002' and  '00005'.


   out->write( <gs_employees> ).


    endloop.


ENDMETHOD.
ENDCLASS.
