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
"Declaracion una variable de referencia lr_data y le asignamos memoria para un entero ( tipo i)
    DATA(lr_data) = NEW i(  ).


    "asociamos el contenido de la referencia lr_data ( el entero en memoria)
    "a un field-symbol <lfs_value>, para poder manipularlo de forma directa.
    ASSIGN lr_data->* TO FIELD-SYMBOL(<lfs_value>).


    "modificamos el valor apuntado por <lfs_value> ( es decir el entero en memoria)
    " y lo establecemos a 30
    <lfs_value> = 30.


*    "Declaramos una referencia lr_class y creamos un nuevo objeto de la clase ZCL_xxxx
*    "llamando a su constructor ( El parentesis vacio indica constructor sin paramentros )
*    data(lr_class) = new zcl_new2_jpf(  ).
*

"EJERCICIOS FIELD-SYMBOL

"Trabajando con la tabla de BD ZTAB_JORGE (campos típicos: MANDT, ID, FIRST_NAME, LAST_NAME,
"EMAIL, PHONE_NUMBER, SALARY, CURRENCY_CODE):
 "1. Crea un field-symbol sobre una variable simple y demuestra que cambiar el field-symbol"
 "cambia la variable base.

 DATA: Lv_variable type string.
 FIELD-SYMBOLS: <gfs_variable>  TYPE string.
 ASSIGN lv_variable to <gfs_variable>.
 lv_variable = 'Pepe'.
 <gfs_variable> = 'Laura'.
 out->write( <gfs_variable> ).
* <gfs_variable> =  ZTAB_JORGE[ 2 ]-first_name.

" 2. Carga todos los empleados de ZTAB_BD_DER en una tabla interna.

SELECT
FROM ZTAB_JORGE
FIELDS *
INTO TABLE @DATA(lt_empleados).
out->write( lt_empleados ).

"3. Haz dos bucles:
"• A) LOOP ... INTO y cambia el EMAIL (no debe afectar a la tabla interna).

LOOP AT lt_empleados INTO data(ls_revision).
ls_revision-email = 'nuevo@mail.com'.
ENDLOOP.



"B) LOOP ... ASSIGNING y cambia el EMAIL (sí debe afectar a la tabla interna).
FIELD-SYMBOLS: <fs_revision> TYPE ztab_jorge.
LOOP AT lt_empleados ASSIGNING  <fs_revision> .
<fs_revision>-email = 'nuevo@mail.com'.

ENDLOOP.
out->write( lt_empleados ).

"4.Añade un empleado con APPEND INITIAL LINE ... ASSIGNING

* FIELD-SYMBOLS: <gfs_empleado>  TYPE string.
* ASSIGN lv_empleado to <gfs_empleado>.


APPEND INITIAL LINE TO lt_empleados ASSIGNING <fs_revision>.
<fs_revision>-first_name = 'Jorge'.
<fs_revision>-email = 'nuevo@mail.com'.


out->write( lt_empleados ).

"5.Inserta otro empleado en posición 2 con INSERT INITIAL LINE ... ASSIGNING
INSERT INITIAL LINE INTO lt_empleados INDEX 2 ASSIGNING <fs_revision>.
<fs_revision>-first_name = 'Pedro'.
<fs_revision>-email = 'nuevo@mail.com'.


out->write( lt_empleados ).


"6.
data lv_encontrado type i.
*
*LOOP AT lt_empleados ASSIGNING FIELD-SYMBOL(<fs_empleados>).
*
*IF lt_empleados-first_name = 'Mario'.
*<fs_empleados>-last_name = 'Pérez'.
*<fs_empleados>-email = 'mario.perez@mail.com'.
*lv_encontrado = 1.
*
*endif.
*
*IF lv_encontrado <> 1
*out->write( 'no encontrado' ).

   IF line_exists( lt_empleados[ first_name = 'Mario' ] ).
LOOP AT lt_empleados ASSIGNING FIELD-SYMBOL(<fs_empleados>).

IF <fs_empleados>-first_name = 'Mario'.
<fs_empleados>-last_name = 'Pérez'.
<fs_empleados>-email = 'mario.perez@mail.com'.
endif.
endloop.

   ELSE.      out->write( 'no encontrado' ).

endif.
out->write( lt_empleados ).

ENDMETHOD.
ENDCLASS.
