CLASS zcl_ejer_referencia_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_ejer_referencia_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

"EJERCICIOS REFERENCIA-CORRECCIÓN DEL PROFESOR ABAJO LINEA 275

"Crea una referencia tipada a i, reserva memoria con CREATE DATA,
"asígnala a un field-symbol y escribe/lee su valor.

DATA referencia1 TYPE REF TO i.
CREATE DATA referencia1 TYPE i.
referencia1->* = 1000.

out->write( referencia1->* ).
out->write( |\n| ).

"Crea una referencia genérica REF TO data, hazla apuntar a un string,
"asígnala a <any> y modifícala.

data(lv_cadena) = 'prueba'.
DATA referencia2 TYPE REF TO data.
referencia2 = ref #( lv_cadena ).
out->write( referencia2->* ).
out->write( |\n| ).

"Define una estructura plana ty_person y crea una referencia a esa estructura;
"asígnala a <ls> y rellena campos.


types: begin of ty_person,
       nombre type char13,
       apellido type char13,
       departamento type char13,
       experiencia type i,
       proyectos type string,
       end of ty_person.


data: ls_tab_person TYPE ty_person.

data referencia3 type ref to ty_person.
referencia3 = ref #( ls_tab_person ).

referencia3->* = value #( nombre = 'David' apellido = 'García' departamento = 'programación' experiencia = 5 ).

out->write( |\n| ).

"Define un tipo de tabla ty_tab_person y crea una referencia a la tabla;
"asígnala a <lt> y añade filas (APPEND).


types: ty_tab_person TYPE TABLE OF ty_person with empty key.
data: lt_tab_person TYPE ty_tab_person.
append referencia3->* TO lt_tab_person.

"(añado otra fila)
referencia3->* = value #( nombre = 'Isabel' apellido = 'Hernández' departamento = 'logística' experiencia = 3 ).
append referencia3->* TO lt_tab_person.

out->write( lt_tab_person ).
out->write( |\n| ).


"Toma una referencia a una línea concreta con REF #( <tabla>[ 2 ] )
" y cámbiala vía ->*; comprueba el cambio en la tabla


data referencia4 type ref to ty_person.
referencia4 = ref #( lt_tab_person[ 2 ] ).

referencia4->nombre = 'Cristina'.

out->write( lt_tab_person ).
out->write( |\n| ).

"Usa la variante OPTIONAL para referenciar una línea inexistente
" y comprueba IS BOUND antes de desreferenciar.

referencia4 = ref #( lt_tab_person[ 10 ] OPTIONAL ).

if referencia4 IS BOUND.
out->write( referencia4->* ).
ELSE.
out->write( 'no existe la fila' ).
ENDIF.

out->write( |\n| ).
out->write( |\n| ).

"Crea una estructura profunda (string + tabla interna dentro)
" y manipúlala solo a través de la referencia.

types:begin of ty_proyectos,
      nombre_proyecto type char13,
      descripcion type string,
      prioridad type zde_prioridad_jpf,
      end of ty_proyectos.


types:begin of ty_departamentos,
      nombre_departamento type char13,
      proyectos type ty_proyectos,
            end of ty_departamentos.
data lt_departamentos type table of ty_departamentos.

 data referencia5 type ref to ty_departamentos.

 CREATE DATA referencia5.

 referencia5->*-nombre_departamento = 'programación'.
  referencia5->*-proyectos-nombre_proyecto = 'nueva Z'.
  referencia5->*-proyectos-descripcion = 'crear nueva transación Z para finanzas'.
  referencia5->*-proyectos-prioridad = 'baja'.


append referencia5->* to lt_departamentos.

out->write( lt_departamentos ).

"(creo otras filas)

referencia5->*-nombre_departamento = 'programación'.
  referencia5->*-proyectos-nombre_proyecto = 'arreglar bug'.
  referencia5->*-proyectos-descripcion = 'bug urgente en mercancías recibidas'.
  referencia5->*-proyectos-prioridad = 'alta'.


append referencia5->* to lt_departamentos.


referencia5->*-nombre_departamento = 'contabilidad'.
  referencia5->*-proyectos-nombre_proyecto = 'balance '.
  referencia5->*-proyectos-descripcion = 'presentar balance tercer trimestre'.
  referencia5->*-proyectos-prioridad = 'alta'.


append referencia5->* to lt_departamentos.
out->write( lt_departamentos ).



 "Crea una tabla de referencias a líneas: guarda REF #( <tabla>[ idx ] )
 "en otra tabla y modifica varias filas

TRY.

 data refx type ref to ty_departamentos.
 refx = ref #( lt_departamentos[ 5 ] ).
 out->write( refx->* ).

CATCH CX_SY_ITAB_LINE_NOT_FOUND.

out->write( 'línea no encontrada' ).

endtry.

"meter una tabla en otra (experimento)
"primero creo un nuevo tipo para la tabla de departamentos para colocar la estructura anidada





            types:begin of ty_proyectos2,
      nombre_proyecto type char13,
      descripcion type string,
      prioridad type zde_prioridad_jpf,
      end of ty_proyectos2.

      TYPES: ty_tabla_proyectos2 TYPE STANDARD TABLE OF ty_proyectos2 WITH EMPTY KEY.

      types:begin of ty_departamentos2,
      nombre_departamento type string,
      proyectos type ty_tabla_proyectos2,
            end of ty_departamentos2.



"nuevas tablas
data lt_departamentos2 type table of ty_departamentos2.
data lt_proyectos type  ty_tabla_proyectos2.
data ls_proyectos2 type ty_proyectos2.

"rellenamos table de dentro
ls_proyectos2 = value #( nombre_proyecto = 'crea tabla' descripcion = 'nueva tabla de vuelos' prioridad = 'baja' ).
append ls_proyectos2 to lt_proyectos.
ls_proyectos2 = value #( nombre_proyecto = 'incidencia' descripcion = 'problema logística' prioridad = 'alta' ).
append ls_proyectos2 to lt_proyectos.


"rellenamos tabla de fuera

data ls_departamentos2 type ty_departamentos2.

ls_departamentos2 = value #( nombre_departamento = 'programación' proyectos = lt_proyectos ).

out->write( ls_departamentos2 ).











"
"Pasa por un pequeño “pipeline”: de ref genérica → <any> → escribe por consola;
"muestra diferencia entre IS BOUND e IS ASSIGNED.

*ls_referencias_lineas = lt_referencias_lineas[ 1 ].
**********************************************************************data ref_lineas type ref to data.
*ref_lineas = ref #( lt_referencias_lineas ).
*
*out->write( ref_lineas->* ).

"""""REFERENCE INTO DATA
TYPES: BEGIN OF ty_emp,
             id     TYPE i,
             nombre TYPE string,
             ciudad TYPE string,
             sueldo TYPE decfloat34,
           END   OF ty_emp.

    DATA lt_emp TYPE STANDARD TABLE OF ty_emp WITH EMPTY KEY.

    lt_emp = VALUE #(
      ( id = 1 nombre = 'Ana'    ciudad = 'Madrid'  sueldo = 32000 )
      ( id = 2 nombre = 'Luis'   ciudad = 'Sevilla' sueldo = 29500 )
      ( id = 3 nombre = 'Sara'   ciudad = 'Bilbao'  sueldo = 31000 )
      ( id = 4 nombre = 'Diego'  ciudad = 'Valencia' sueldo = 28000 ) ).




    DATA lt_emp_ref TYPE STANDARD TABLE OF REF TO ty_emp WITH EMPTY KEY.
    LOOP AT lt_emp REFERENCE INTO DATA(lsr_emp).

      APPEND lsr_emp TO lt_emp_ref.
    ENDLOOP.


    out->write( |Filas en lt_emp: { lines( lt_emp ) }| ).
    out->write( |Referencias en lt_emp_ref: { lines( lt_emp_ref ) }| ).

out->write( lt_emp ).
*out->write( lt_emp_ref ).


    MODIFY lt_emp FROM VALUE ty_emp( id = 1 nombre = 'Ana*' ciudad = 'Madrid' sueldo = 32000 ) INDEX 1.
    out->write( |Nombre 1ª fila (vía ref): { lt_emp_ref[ 1 ]->nombre }| ).


out->write( lt_emp ).
out->write( lt_emp_ref ).


"CORRECCIÓN DEL PROFE
*--- 1) Referencia tipada + field-symbol --------------------------------------
    DATA lr_i TYPE REF TO i.                         "declara ref a entero (aún vacía)
    CREATE DATA lr_i.                                "reserva un entero y lo hace apuntar
    FIELD-SYMBOLS <i> TYPE i.                        "alias temporal de entero (sin memoria)
    ASSIGN lr_i->* TO <i>.                           "asigna el entero apuntado al alias
    <i> = 42.                                        "escribe 42 a través del alias
    out->write( |[1] lr_i->*={ lr_i->* } / <i>={ <i> }| ).  "mismo valor por ref y alias

*--- 2) Referencia genérica a string + alias genérico -------------------------
    DATA lr_any TYPE REF TO data.                    "ref genérica (a cualquier tipo)
    DATA lv_text TYPE string VALUE 'hola'.           "string con valor inicial
    GET REFERENCE OF lv_text INTO lr_any.            "apunta a la variable existente
    FIELD-SYMBOLS <any> TYPE any.                    "alias genérico (tipo ANY)
    ASSIGN lr_any->* TO <any>.                       "engancha alias genérico al dato
    <any> = |{ <any> } mundo|.                       "modifica lv_text indirectamente
    out->write( |[2] lv_text={ lv_text }| ).         "muestra 'hola mundo'

*--- 3) Estructura por referencia ------------------------------------------------
*    TYPES: BEGIN OF ty_person,                       "estructura persona
*             id   TYPE i,
*             name TYPE string,
*           END OF ty_person.
*    DATA lr_pers TYPE REF TO ty_person.              "ref a estructura persona
*    CREATE DATA lr_pers.                             "reserva memoria para la estructura
*    FIELD-SYMBOLS <ls_pers> TYPE ty_person.          "alias de la estructura
*    ASSIGN lr_pers->* TO <ls_pers>.                  "engancha alias a la estructura real
*    <ls_pers>-id   = 1.                              "rellena campos
*    <ls_pers>-name = 'Ana'.
*    out->write( |[3] person id={ <ls_pers>-id } name={ <ls_pers>-name }| ).
*
**--- 4) Tabla interna por referencia y APPEND -----------------------------------
*    TYPES ty_tab_person TYPE STANDARD TABLE OF ty_person WITH EMPTY KEY. "tipo tabla
*    DATA lr_tab TYPE REF TO ty_tab_person.           "ref a la tabla interna
*    CREATE DATA lr_tab.                              "reserva la tabla vacía
*    FIELD-SYMBOLS <lt_pers> TYPE ty_tab_person.      "alias de la tabla
*    ASSIGN lr_tab->* TO <lt_pers>.                   "engancha alias a la tabla real
*    APPEND VALUE ty_person( id = 1 name = 'Ana'  ) TO <lt_pers>.  "insertar filas
*    APPEND VALUE ty_person( id = 2 name = 'Luis' ) TO <lt_pers>.
*    APPEND VALUE ty_person( id = 3 name = 'Marta' ) TO <lt_pers>.
*    out->write( data = <lt_pers> name = '[4] Tabla personas (inicial)' ). "imprime
*
**--- 5) Referencia a una LÍNEA concreta y edición vía ->* ----------------------
*    DATA lr_line2 TYPE REF TO ty_person.             "ref a una línea de la tabla
*    TRY.
*        lr_line2 = REF #( <lt_pers>[ 2 ] ).          "toma ref a fila 2 (Luis)
*        lr_line2->*-name = 'Luis (edit)'.            "modifica el campo name vía ref
*      CATCH cx_sy_itab_line_not_found.               "si no existe la fila
*        out->write( '[5] No existe la línea 2' ).
*    ENDTRY.
*    out->write( data = <lt_pers> name = '[5] Tras editar línea 2' ).
*
**--- 6) OPTIONAL al referenciar línea inexistente --------------------------------
*    DATA lr_line99 TYPE REF TO ty_person.            "ref potencial a fila 99
*    lr_line99 = REF #( <lt_pers>[ 99 ] OPTIONAL ).   "no lanza excepción si no hay fila
*    IF lr_line99 IS BOUND.                           "¿apunta a algo?
*      out->write( '[6] lr_line99 BOUND' ).           "sí, improbable aquí
*    ELSE.
*      out->write( '[6] lr_line99 NO BOUND' ).        "no se encontró la línea
*    ENDIF.
*
**--- 7) Estructura profunda: tabla dentro de estructura -------------------------
*    TYPES: BEGIN OF ty_order_item,                   "líneas de pedido
*             product TYPE string,
*             qty     TYPE i,
*           END OF ty_order_item.
*    TYPES ty_items TYPE STANDARD TABLE OF ty_order_item WITH EMPTY KEY. "tabla de items
*
*    TYPES: BEGIN OF ty_customer_deep,                "cliente con tabla interna
*             id    TYPE i,
*             name  TYPE string,
*             items TYPE ty_items,
*           END OF ty_customer_deep.
*
*    DATA lr_cust TYPE REF TO ty_customer_deep.       "ref a estructura profunda
*    CREATE DATA lr_cust.                             "reserva memoria
*    FIELD-SYMBOLS <ls_cust> TYPE ty_customer_deep.   "alias de la estructura
*    ASSIGN lr_cust->* TO <ls_cust>.                  "engancha alias
*    <ls_cust>-id = 10.                               "rellena datos simples
*    <ls_cust>-name = 'Cliente X'.
*    APPEND VALUE ty_order_item( product = 'A' qty = 2 ) TO <ls_cust>-items. "añade item
*    APPEND VALUE ty_order_item( product = 'B' qty = 1 ) TO <ls_cust>-items.
*    out->write( data = <ls_cust> name = '[7] Cliente profundo' ). "imprime todo
*
**--- 8) Tabla de REFERENCIAS a líneas y edición indirecta -----------------------
*    TYPES: BEGIN OF ty_person_ref,                   "estructura que guarda una ref
*             ref TYPE REF TO ty_person,
*           END OF ty_person_ref.
*    TYPES ty_tab_person_ref TYPE STANDARD TABLE OF ty_person_ref WITH EMPTY KEY. "tabla de refs
*
*    DATA lt_refs TYPE ty_tab_person_ref.             "tabla con referencias a filas
*    APPEND VALUE #( ref = REF #( <lt_pers>[ 1 ] ) ) TO lt_refs. "guarda ref fila 1
*    APPEND VALUE #( ref = REF #( <lt_pers>[ 3 ] ) ) TO lt_refs. "guarda ref fila 3
*
*    LOOP AT lt_refs INTO DATA(ls_ref).               "recorre refs guardadas
*      IF ls_ref-ref IS BOUND.                        "si la ref está ligada
*        ls_ref-ref->*-name = |{ ls_ref-ref->*-name } (OK)|. "edita nombre via ref
*      ENDIF.
*    ENDLOOP.
*    out->write( data = <lt_pers> name = '[8] Editado vía referencias' ).
*
**--- 9) Pipeline genérico: ref genérica -> alias -> salida ----------------------
*    DATA lr_gen TYPE REF TO data.                    "ref genérica
*    lr_gen = REF #( <ls_cust>-name ).                "apunta al campo name del cliente
*    IF lr_gen IS BOUND.                              "comprueba ref
*      FIELD-SYMBOLS <g> TYPE any.                    "alias genérico
*      ASSIGN lr_gen->* TO <g>.                       "engancha alias al dato
*      out->write( |[9] Nombre cliente (genérica) = { <g> }| ). "imprime
*    ENDIF.
*
**--- 10) Liberar la referencia tipada y chequear --------------------------------
*    FREE lr_i.                                       "libera el entero referenciado
*    IF lr_i IS NOT BOUND.                            "ya no apunta a nada
*      out->write( '[10] lr_i liberada; NO BOUND' ).
*    ENDIF.
**   Regla: nunca hagas lr_i->* sin comprobar IS BOUND (daría dump).
*
**=== BONUS: empleados + tabla de referencias a cada fila ========================
*    TYPES: BEGIN OF ty_emp,                          "estructura empleado
*             id     TYPE i,
*             nombre TYPE string,
*             ciudad TYPE string,
*             sueldo TYPE decfloat34,
*           END OF ty_emp.
*
*    DATA lt_emp TYPE STANDARD TABLE OF ty_emp WITH EMPTY KEY. "tabla interna simple
*    lt_emp = VALUE #(
*      ( id = 1 nombre = 'Ana'   ciudad = 'Madrid'   sueldo = 32000 )
*      ( id = 2 nombre = 'Luis'  ciudad = 'Sevilla'  sueldo = 29500 )
*      ( id = 3 nombre = 'Sara'  ciudad = 'Bilbao'   sueldo = 31000 )
*      ( id = 4 nombre = 'Diego' ciudad = 'Valencia' sueldo = 28000 ) ).
*
*    DATA lt_emp_ref TYPE STANDARD TABLE OF REF TO ty_emp WITH EMPTY KEY. "tabla de refs
*    LOOP AT lt_emp REFERENCE INTO DATA(lsr_emp).     "itera por empleados
*      APPEND lsr_emp TO lt_emp_ref.                  "guarda ref de cada fila
*    ENDLOOP.
*
*    IF lines( lt_emp_ref ) >= 3 AND lt_emp_ref[ 3 ] IS BOUND. "si hay 3ª ref
*      lt_emp_ref[ 3 ]->*-sueldo = 31500.             "sube sueldo a la fila 3 vía ref
*    ENDIF.
*
*    out->write( data = lt_emp name = '[B] Empleados tras editar por ref' ). "imprime final
*

ENDMETHOD.
ENDCLASS.
