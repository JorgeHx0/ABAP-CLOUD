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


*
*
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
*
*    lt_employee = VALUE #( ( emp_name = 'Pedro'
*                              emp_age = 30 ) ).
*
*    out->write( data = lt_employee name = 'lt_employee' ).
*    lt_person = CORRESPONDING #( lt_employee MAPPING name = emp_name  " usamos el mapping para "igualar" los encabezado de las dos tablas
*                                                      age = emp_age ).
*    out->write( |\n| ).
*    out->write( data = lt_person name = 'lt_person' ).
*
*    "corresponding con el BASE
*
*    lt_client =  VALUE #( ( name = 'Maria '
*                            age = 50 ) ).
*
*    lt_client = CORRESPONDING #( BASE ( lt_client ) lt_person ).
*
*    out->write( |\n| ).
*    out->write( data = lt_client name = 'lt_client' ).
*
*    "Excep
*
*    lt_person = CORRESPONDING #( lt_client EXCEPT name ).
*    out->write( |\n| ).
*    out->write( data = lt_person name = 'lt_person' ).

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

*    out->write( |\n| ).
*    out->write( data = lt_itab2 name = 'lt_itab2' ).
*    out->write( |\n| ).
*    out->write( data = lt_itab1 name = 'lt_itab1' ).
*
*
*    lt_itab2 = CORRESPONDING #( lt_itab1 DISCARDING DUPLICATES ).
*    out->write( |\n| ).
*    out->write( data = lt_itab2 name = 'lt_itab2' ).

"otra forma de solucionarlo, sin necesidad de tabla sorted.

*    DATA: lt_itab1 TYPE TABLE OF ty_person WITH EMPTY KEY,
*          lt_itab2 TYPE TABLE OF ty_person WITH EMPTY KEY.
*
*
*    lt_itab1  = VALUE #( ( name = 'maria'  age = 22 )
*                         ( name = 'maria'  age = 25 )
*                         ( name = 'maria'  age = 22 )
*                         ( name = 'pedro'  age = 24 )
*                         ( name = 'javier'  age = 24 )
*                         ( name = 'maria'  age = 33 )
*                         ( name = 'laura'  age = 24 )
*                         ( name = 'javier'  age = 24 )
*                          ).
*
*
*  lt_itab2 = CORRESPONDING #( lt_itab1 ).
*
*
*data lv_cont1 type i.
*data lv_cont2 type i.
*
*loop at lt_itab2 into data(ls_itab2_A).
*lv_cont2 = 0.
*lv_cont1 = lv_cont1 + 1.
*
*loop at lt_itab2 into data(ls_itab2_B).
*lv_cont2 = lv_cont2 + 1.
*
*if ls_itab2_A = ls_itab2_B AND lv_cont1 <> lv_cont2.

*delete lt_itab2.
*
*endif.
*
*endloop.
*endloop.
*
* out->write( lt_itab2 ).
*
*

"CONV le pasa el valor de una variable a otra modificando su tipo.

data(lv_number) = 2025.
data(lv_text) = CONV string( lv_number ).

out->write( |Numero original (entero): { lv_number } | ).
out->write( |Numero original convertido a texto: { lv_text } | ).

data(lv_str_number) = '150'.
DATA(lv_int_number) = conv i( lv_str_number ).

out->write( |Numero original (texto): { lv_str_number } | ).
out->write( |Numero original convertido a entero: { lv_int_number } | ).


"EXACT Es igual que el CONV pero con "mas poder" si hay perdida de datos en el proceso de conversion lanza
    "un error en tiempo de ejecucion.

    DATA lv_num  TYPE p LENGTH 5 DECIMALS 2 VALUE '123.45'.

    "converion con CONV (funciona incluso si hubiera redondeo)
    DATA(lv_conv) = CONV i( lv_num ). "resultado: 123
    out->write( |CONV a entero: { lv_conv }| ).

    "converion con EXACT (falla si hay perdida de datos)

    TRY. " utilizamos el try catch que hemos visto en otras clases para controlar el error en caso
           " de que se diese una perdida de datos por culpa de la conversion.
           "en el caso de este ejemplo se produce la perdida pero si le quitamos en la declaracion del variable
           "lv_num el .45 ya si que no nos daria ninguna exacepcion

        DATA(lv_exact) = EXACT i( lv_num ).
        out->write( |EXACT a entero: { lv_exact }| ).

      CATCH cx_sy_conversion_error INTO DATA(lx_error).
        out->write( |Error EXACT: { lx_error->get_text(  ) }| ).

    ENDTRY.


*types: begin of ty_flights,
*client type /dmo/flight-client,
*carrier_id type /dmo/carrier_id,
*conection_id type /dmo/connection_id,
*currency_code type /dmo/currency_code,
*end of ty_flights


TYPES: Ty_tabla_vuelos TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY.

data lt_vuelos TYPE ty_tabla_vuelos.

out->write( lt_vuelos ).


ENDMETHOD.




ENDCLASS.
