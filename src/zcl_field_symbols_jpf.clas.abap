CLASS zcl_field_symbols_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_field_symbols_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

" Declaración de variables y tablas internas
    DATA gv_employee      TYPE string.
    DATA gt_employees     TYPE STANDARD TABLE OF ztab_jorge.
    DATA gt_employees_for TYPE STANDARD TABLE OF ztab_jorge.

    FIELD-SYMBOLS: <gfs_employee>  TYPE string,
                   <gfs_employee2> TYPE ztab_jorge. " field-symbol a una **linea** de la tabla Zxxxxxx

    " Asignar y usar un field-symbol con variable simple
    ASSIGN gv_employee TO <gfs_employee>.
    <gfs_employee> = 'Maria'.
    "out->write( <gfs_employee> ).


    UNASSIGN <gfs_employee>.

    " Seleccionar todos los empleados de la tabla Z
    SELECT FROM ztab_jorge
           FIELDS *
           INTO TABLE @gt_employees.


    LOOP AT gt_employees INTO DATA(gs_employee). " itera copuando cda fila en gs_emloyee ( estructura local)
      gs_employee-email = 'nuevo@email.com'.     " cambia el email **solo en la copia**, no en gt_employees
    ENDLOOP.                                     " fin del bucle por copia ( no persiste camnos en la tabla )

    out->write( gs_employee ).
    out->write( |\n| ).
    out->write( data = gt_employees name = 'Structure' ). "Muestra gt_employees "(deberia seguir sin cambios) "

*
*    LOOP AT gt_employees ASSIGNING <gfs_employee2>.    " Itera ASSIGNING haciendo referencia a la fila real de gt_employees
*      <gfs_employee2>-email = 'nuevo@email.com'.       " Modifica el email **en la fila real** de gt_employees
*    ENDLOOP.                                           " Fin del bulcle por referencia ( si persisten los cambios)
*    out->write( |\n| ).
*    out->write( data = gt_employees name = 'Field symbols' ). "Muestra gt_employees ya con los emails modificados


    gt_employees_for = VALUE #(                  " construye otra tabla a partir de gt_employees
      FOR <gfs_employee3> IN gt_employees        " bucle de compresion: recorre cada fila
      ( CORRESPONDING #( <gfs_employee3> ) )     " inserta una linea copiando campos por Nombre (1:1)
    ).                                           " gt_emloyees_for queda como copia de gt_employees
    out->write( |\n| ).
    out->write( data = gt_employees_for name = 'gt_employees_for' ).  "muestra el resultado de la copia de gt_employees, en la nueva tabla
                                                                      " gt_employees_for que ha sido introducida por el for.


""la declaración en línea se hace con ASSIGNING FIELD SYMBOL <gfs_ejemplo>

"AÑADIR REGISTROS

"AÑADIR REGISTROS
*
*    SELECT
*    from ztab_jorge
*    FIELDS *
*    into table @DATA(gt_employees2).
*
*out->write( data =  gt_employees name = 'gt_employees' ).
*out->write( |\n| ).
*
*    append INITIAL LINE TO gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_apd>).
*
*    <lfs_employee_apd> = value #(
*                                mandt         = sy-mandt
*                                id            = 00000005
*                                first_name    = 'Pedro'
*                                last_name     = 'Mora'
*                                email         = 'mora@experis.es'
*                                phone_number  = 38512369
*                                salary        = '2000'
*                                currency_code = 'EUR'     ).
*
*
*out->write( data =  gt_employees name = 'gt_employees' ).
*
*
*
*    DATA lv_field TYPE string VALUE 'field2'.
*    ASSIGN ls_data-(lv_field) TO <lfs_generic>.     " asignacion por "nombre en variable" field2
*    out->write( <lfs_generic> ).                    " muestra aaa
*
*    ASSIGN ('ls_data-field1') to <lfs_generic>.     "asignacion por "nombre absoluto" en c adena
*     out->write( <lfs_generic> ).                   " muestra 1
*
*     ASSIGN ls_data-(3) to <lfs_generic>.           "Asignacion por "posicion"  (3= field3)
*       out->write( <lfs_generic> ).                 "muestra z
ENDMETHOD.
ENDCLASS.
