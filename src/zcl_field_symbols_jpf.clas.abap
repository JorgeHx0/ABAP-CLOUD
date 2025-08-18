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


    LOOP AT gt_employees INTO DATA(gs_employee). " itera copuando cda fila en gs_emloyee ( estructura loca)
      gs_employee-email = 'nuevo@email.com'.     " cambia el email **solo en la copia**, no en gt_employees
    ENDLOOP.                                     " fin del bucle por copia ( no persiste camnos en la tabla )

    out->write( gs_employee ).
    out->write( |\n| ).
    out->write( data = gt_employees name = 'Structure' ). "Muestra gt_employees "(deberia seguir sin cambios) "


    LOOP AT gt_employees ASSIGNING <gfs_employee2>.    " Itera ASSIGNING haciendo referencia a la fila real de gt_employees
      <gfs_employee2>-email = 'nuevo@email.com'.       " Modifica el email **en la fila real** de gt_employees
    ENDLOOP.                                           " Fin del bulcle por referencia ( si persisten los cambios)
    out->write( |\n| ).
    out->write( data = gt_employees name = 'Field symbols' ). "Muestra gt_employees ya con los emails modificados


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

    SELECT
    from ztab_jorge
    FIELDS *
    into table @DATA(gt_employees2).

out->write( data =  gt_employees name = 'gt_employees' ).
out->write( |\n| ).

    append INITIAL LINE TO gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_apd>).

    <lfs_employee_apd> = value #(
                                mandt         = sy-mandt
                                id            = 00000005
                                first_name    = 'Pedro'
                                last_name     = 'Mora'
                                email         = 'mora@experis.es'
                                phone_number  = 38512369
                                salary        = '2000'
                                currency_code = 'EUR'     ).


out->write( data =  gt_employees name = 'gt_employees' ).


    " Leer registros

    SELECT
FROM ztab_jorge
FIELDS *
INTO TABLE @DATA(gt_employees3).



    READ TABLE gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_rd>) WITH KEY first_name = 'Mario'.

    <lfs_employee_rd>-last_name = 'Rivera'.
    <lfs_employee_rd>-email      = 'rivera@expris.es '.

    out->write( data =  gt_employees name = 'gt_employees' ).



    "PROGRAMACIÓN DINÁMICA

    "field symbols dinámicos

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*                                PROGRAMACION DINAMICA
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "field-symbols dinamicos

    FIELD-SYMBOLS: <gt_employees> TYPE ANY TABLE, "Puntero a una tabla interna generica
                   <gs_employee>  TYPE any, " puntero a un registro/estructura generia
                   <gs_data>      TYPE any.  " puntero a un campo generico


    "Crea un registro de ejemplo en base a la tabla ZTAB_BD_DER
    DATA(gs_employee3) = VALUE ztab_jorge(
                                    mandt         = sy-mandt
                                    id            = '00000005'
                                    first_name    = 'Pedro'
                                    last_name     = 'Mora'
                                    email         = 'mora@experis.es'
                                    phone_number  = 38512369
                                    salary        = '2000'
                                    currency_code = 'EUR'    ).


    "Asignar el registro gs_employee al field-symbol <gs_employee>

    ASSIGN gs_employee TO <gs_employee>.


    "Verificar que el field-symbol <gs_employee> esta asignado
    IF <gs_employee> IS ASSIGNED.

        "Asignar dinamicamente el componente 'first_name' del registro <gs-employee> al field-symbol <gs_data>
        ASSIGN COMPONENT 'FIRST_NAME' of STRUCTURE <gs_employee> to <gs_data>.

            "Verificar que el field-symbol <gs_data> esta asignado
            if <gs_data> is ASSIGNED.
                "Modifica dinamicamente el valor del campo first_name a Maria
                <gs_data> = 'Maria'.

                "liberar la asignacion del field-symbol <gs_data>
                UNASSIGN <gs_data>.
            ENDIF.

            UNASSIGN <gs_employee>.
    ENDIF.

    out->write(
        data = gs_employee
        name = 'Programacion Dinamica'
    ).






ENDMETHOD.
ENDCLASS.
