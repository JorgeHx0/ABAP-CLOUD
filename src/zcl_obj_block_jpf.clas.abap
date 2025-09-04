CLASS zcl_obj_block_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_obj_block_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.




data lv_comprobacion type c length 1.

while lv_comprobacion <> 0.

"primera parte de sentencia de bloqueo

out->write( 'El usuario ha empezado el programa' ).

try.

data(lo_lock_object) = cl_abap_lock_object_factory=>get_instance( EXPORTING iv_name = 'EZ_BLOCK_JPF' ).
catch cx_abap_lock_failure.
out->write( 'El objeto no se ha creado' ).
RETURN.
endtry.

"try.
data lt_parameter type if_abap_lock_object=>tt_parameter.
lt_parameter = VALUE #( ( name = 'ID'
                            value = REF #( '001' ) )
                            ( name = 'matricula'
                            value = REF #( 'o' ) ) ).

 TRY.
 lo_lock_object->enqueue(     "ctr espacio y después ctr enter
*   it_table_mode =
  it_parameter  = lt_parameter
*   _scope        =
*   _wait         =
 ).
 CATCH
 cx_abap_foreign_lock
 cx_abap_lock_failure.
 out->write( 'El objeto ya está siendo tratado por otro usuario' ).
 RETURN.

 endtry.


out->write( 'El objeto ya está disponible' ).

"------segunda parte, "intento de crear una nueva fila"

data ls_new_registro type ztab_jorge2_jpf.

ls_new_registro = VALUE #(  mandt         = '100'
      id            = 005
      matricula       = 'i'
      first_name    = 'Karol'
      last_name     = 'Pérez'
      email         = 'kperez@example.com'
      phone_number  = '546987'
      salary        = '5000.00'
      currency_code = 'USD'  ).

wait up to 30 seconds.

MODIFY ztab_jorge2_jpf FROM @ls_new_registro.

"-----tercera parte. liberación del objeto

IF sy-subrc = 0.
out->write( 'la base de datos ha sido actualizada' ).
endif.

try.

lo_lock_object->dequeue( it_parameter = lt_parameter ).  "desbloquea
catch cx_abap_lock_failure.
out->write( 'El objeto NO ha sido liberado' ).
endtry.
out->write( 'El objeto ha sido liberado' ).
lv_comprobacion = 1.

wait up to 60 seconds.

endwhile.


ENDMETHOD.
ENDCLASS.
