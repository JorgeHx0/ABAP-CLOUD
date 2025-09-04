CLASS zcl_clase_tablas_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_clase_tablas_jpf IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.
DELETE FROM ZTABCOPIA_JPF.
INSERT ZTABCOPIA_JPF FROM TABLE @( value #( ( mandt         = '100'
      id            = 001
      matricula       = 'o'
      first_name    = 'Laura'
      last_name     = 'Martinez'
      email         = 'lauram@example.com'
      phone_number  = '38512369'
      salary        = '2000.30'
      currency_code = 'EUR' )


      ( mandt         = '100'
      id            = 002
      matricula       = 'o'
      first_name    = 'Laura'
      last_name     = 'Martinez'
      email         = 'lauram@example.com'
      phone_number  = '38512369'
      salary        = '2000.30'
      currency_code = 'EUR' ) ) ).

SELECT FROM ztabcopia_jpf
FIELDS *
INTO TABLE @data(lt_ztabcopia_jpf).

IF sy-subrc EQ 0.
out->write( lt_ztabcopia_jpf ).
ELSE.
out->write( 'no data' ).
ENDIF.



" Vaciar la tabla antes de cargar datos de ejemplo
DELETE FROM ztab_jorge2_JPF.

" Insertar los registros
MODIFY ztab_jorge2_JPF FROM TABLE @(
  VALUE #(
    ( mandt         = '100'
      id            = 001
      matricula       = 'o'
      first_name    = 'Laura'
      last_name     = 'Martinez'
      email         = 'lauram@example.com'
      phone_number  = '38512369'
      salary        = '2000.30'
      currency_code = 'EUR' )

    ( mandt         = '100'
      id            = 002
      matricula       = 'a'
      first_name    = 'Mario'
      last_name     = 'Martinez'
      email         = 'marion@example.com'
      phone_number  = '38512369'
      salary        = '2000.30'
      currency_code = 'EUR' )

    ( mandt         = '100'
      id            = 003
      matricula       = 'e'
      first_name    = 'Daniela'
      last_name     = 'Linares'
      email         = 'daniela@example.com'
      phone_number  = '38512369'
      salary        = '2000.30'
      currency_code = 'EUR' )

    ( mandt         = '100'
      id            = 004
      matricula       = 'i'
      first_name    = 'Karol'
      last_name     = 'Pérez'
      email         = 'kperez@example.com'
      phone_number  = '546987'
      salary        = '5000.00'
      currency_code = 'USD' )
  )
).

select
from ztab_jorge2_JPF
fields *
into table @data(lt_tabla).

*out->write( lt_tabla ).

""""""""""""""


DELETE FROM ZTAB_EMPLOY2_JPF.


MODIFY ZTAB_EMPLOY2_JPF FROM TABLE @(
  VALUE #(
    ( employee_id         = '001'
      first_name    = 'Laura'
      last_name     = 'Martinez'
      start_date         = sy-datum
      category = 'N' )

       ( employee_id         = '002'
      first_name    = 'Mario'
      last_name     = 'Martinez'
      start_date         = '20250815'
      category = 'S' )
( employee_id         = '003'
      first_name    = 'Daniela'
      last_name     = 'Linares'
      start_date         = '20250715'
      category = 'N' )

( employee_id         = '004'
      first_name    = 'Karol'
      last_name     = 'Pérez'
      start_date         = '20250720'
      category = 'N' )


) ).

select
from ZTAB_EMPLOY2_JPF
fields *
into table @data(lt_tabla2).
out->write( lt_tabla2 ).


""""""""""""""
*
*" Vaciar la tabla antes de cargar datos de ejemplo
*DELETE FROM ztab_person_JPF.
*
*
*" Insertar los registros
*MODIFY ztab_person_JPF FROM TABLE @(
*  VALUE #(
*    ( client         = '100'
*      person_id            = 001
*      first_name       = 'Ana'
*      last_name     = 'López'
*      age        = 30
*      street_ad = 'Cuestón'
*      city_ad = 'Cuenca'
*      currency = 'EUR'
*      unit = 'kg'
*
*      -
*
*
*
*
*
*  )
*).
*
*select
*from ztab_jorge2_JPF
*fields *
*into table @data(lt_tabla).
*
**out->write( lt_tabla ).

""""""""""""""


DELETE FROM ZTAB_EMPLOY2_JPF.


MODIFY ZTAB_EMPLOY2_JPF FROM TABLE @(
  VALUE #(
    ( employee_id         = '001'
      first_name    = 'Laura'
      last_name     = 'Martinez'
      start_date         = sy-datum
      category = 'N' )

       ( employee_id         = '002'
      first_name    = 'Mario'
      last_name     = 'Martinez'
      start_date         = '20250815'
      category = 'S' )
( employee_id         = '003'
      first_name    = 'Daniela'
      last_name     = 'Linares'
      start_date         = '20250715'
      category = 'N' )

( employee_id         = '004'
      first_name    = 'Karol'
      last_name     = 'Pérez'
      start_date         = '20250720'
      category = 'N' )


) ).

*select
*from ZTAB_EMPLOY2_JPF
*fields *
*into table @data(lt_tabla2).
*out->write( lt_tabla2 ).







ENDMETHOD.
ENDCLASS.
