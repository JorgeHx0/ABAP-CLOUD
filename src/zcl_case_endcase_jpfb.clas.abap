CLASS zcl_case_endcase_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_case_endcase_jpfb IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.



*    DATA(lv_cliente) = cl_abap_random_int=>create( seed = cl_abap_random=>seed(  )
*    min = 0
*    max = 3 )->get_next( )."generamos número aleatorio entre 1 y 3.
*
*    lv_cliente = lv_cliente + 1.
*
*    out->write( lv_cliente ).
*

**CASE . sólo puedes analizar una comprobación a la vez)
*
*    CASE lv_cliente.
*
*      WHEN 1.
*      out->write( lv_cliente ).
*      out->write( 'el cliente es el 1' ).
*
*      WHEN 2.
*      out->write( lv_cliente ).
*      out->write( 'el cliente es el 2' ).
*
*
*      WHEN 3.
*      out->write( lv_cliente ).
*      out->write( 'el cliente es el 3' ).
*
*      WHEN OTHERS.
*      out->write( lv_cliente ).
*      out->write( 'el cliente no ha sido registrado' ).
*
*    ENDCASE.


*    **************************



DATA(lv_aleatorio) = cl_abap_random_int=>create( seed = cl_abap_random=>seed(  )
    min = 0
    max = 4 )->get_next( )."generamos número aleatorio entre 1 y 4.

DATA: lv_nombre1 type string VALUE 'Daniel',
      lv_nombre2 type string VALUE 'Pedro',
      lv_nombre3 type string VALUE 'Diego',
      lv_nombre4 type string VALUE 'Sara'.

 DATA lv_nombre type string.

IF lv_aleatorio = 1.
lv_nombre = lv_nombre1.

ELSEIF lv_aleatorio = 2.
lv_nombre = lv_nombre2.

ELSEIF lv_aleatorio = 3.
lv_nombre = lv_nombre3.

ELSEIF lv_aleatorio = 4.
lv_nombre = lv_nombre4.

endif.

out->write( lv_nombre ).

CASE lv_nombre.
WHEN 'Daniel'.
out->write( 'Daniel' ).

WHEN 'Pedro'.
out->write( 'Pedro' ).

WHEN 'Diego'.
out->write( 'Diego' ).

WHEN 'Sara'.
out->write( 'Sara' ).

ENDCASE.





  ENDMETHOD.

ENDCLASS.





