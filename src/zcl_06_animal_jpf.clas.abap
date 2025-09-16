CLASS zcl_06_animal_jpf DEFINITION
  PUBLIC
"  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS walk FINAL RETURNING VALUE(rv_walk) type string.
  "el FINAL impide que se haga redefinición en las hijas
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_06_animal_jpf IMPLEMENTATION.
  METHOD walk.
rv_walk = 'El animal anda'.
  ENDMETHOD.

ENDCLASS.

