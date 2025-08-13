CLASS zcl_const_punt_2_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_const_punt_2_jpf IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.




    TYPES: BEGIN OF ty_employee,
             emp_name TYPE string,
             emp_age  TYPE i,
           END OF ty_employee.


    TYPES: BEGIN OF ty_person,
             name TYPE string,
             age  TYPE i,
           END OF ty_person.

    DATA: lt_employee TYPE TABLE OF ty_employee,
          lt_person   TYPE TABLE OF ty_person,
          lt_client   TYPE TABLE OF ty_person.

    lt_employee = VALUE #( ( emp_name = 'Pedro'
                              emp_age = 30 ) ).

    out->write( data = lt_employee name = 'lt_employee' ).
    lt_person = CORRESPONDING #( lt_employee MAPPING name = emp_name  " usamos el mapping para "igualar" los encabezado de las dos tablas
                                                      age = emp_age ).
    out->write( |\n| ).
    out->write( data = lt_person name = 'lt_person' ).

    "corresponding con el BASE

    lt_client =  VALUE #( ( name = 'Maria '
                            age = 50 ) ).

    lt_client = CORRESPONDING #( BASE ( lt_client ) lt_person ).

    out->write( |\n| ).
    out->write( data = lt_client name = 'lt_client' ).

    "Excep

    lt_person = CORRESPONDING #( lt_client EXCEPT name ).
    out->write( |\n| ).
    out->write( data = lt_person name = 'lt_person' ).

"discarting duplicates
*
*    DATA: lt_itab1 TYPE TABLE OF ty_person WITH EMPTY KEY,
*          lt_itab2 TYPE SORTED TABLE OF ty_person WITH UNIQUE KEY name.
*
*    lt_itab1  = VALUE #( ( name = 'maria'  age = 22 )
*                         ( name = 'maria'  age = 25 )
*                         ( name = 'maria'  age = 22 )
*                         ( name = 'Pedro'  age = 24 ) ).
*
*    out->write( |\n| ).
*    out->write( data = lt_itab2 name = 'lt_itab2' ).
*    out->write( |\n| ).
*    out->write( data = lt_itab1 name = 'lt_itab1' ).
*
*
*    lt_itab2 = CORRESPONDING #( lt_itab1 DISCARDING DUPLICATES ).
*    out->write( |\n| ).
*    out->write( data = lt_itab2 name = 'lt_itab2' ).



    DATA: lt_itab1 TYPE TABLE OF ty_person WITH EMPTY KEY,
          lt_itab2 TYPE TABLE OF ty_person WITH EMPTY KEY.

    lt_itab1  = VALUE #( ( name = 'maria'  age = 22 )
                         ( name = 'maria'  age = 25 )
                         ( name = 'maria'  age = 22 )
                         ( name = 'Pedro'  age = 24 ) ).

    out->write( |\n| ).
    out->write( data = lt_itab2 name = 'lt_itab2' ).
    out->write( |\n| ).
    out->write( data = lt_itab1 name = 'lt_itab1' ).


    lt_itab2 = CORRESPONDING #( lt_itab1 DISCARDING DUPLICATES ).
    out->write( |\n| ).
    out->write( data = lt_itab2 name = 'lt_itab2' ).


ENDMETHOD.




ENDCLASS.
