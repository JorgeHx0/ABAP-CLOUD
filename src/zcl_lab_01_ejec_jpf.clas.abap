"1. Clase de ejecución
"Crea un paquete de desarrollo en el que debes crear una clase ABAP con el
"nombre ZCL_LAB_01_EJEC que implementa la interfaz
"“IF_OO_ADT_CLASSRUN” para disponer de la implementación del método
"“MAIN” que será usado más adelante en la en la ejecución de los diferentes
"procesos a implementar.



CLASS zcl_lab_01_ejec_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_01_ejec_jpf IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(lo_objeto) = NEW zcl_lab_04_person_jpf( ).
    "creación de un nuevo objeto

    lo_objeto->set_age( EXPORTING iv_age = 39 ).
    "importamos con un parámetro de importación al que damos valor
    lo_objeto->get_age( IMPORTING   ev_age = DATA(gv_age)  ).
    "guardamos el parámetro de exportación en una nueva variable

    out->write( gv_age ).

    "----ejercicio 6. ver clase zcl_lab_05_flight_jpf------

    "creo variables para los valores que se van a buscar

    DATA lv_carrier_id TYPE string VALUE 'AA'.
    DATA lv_conexion_id TYPE i VALUE 0322.

    "creamos el objeto a partir de una clase
    DATA(Lo_verdadero_o_falso) = NEW zcl_lab_05_flight_jpf(  ).

    Lo_verdadero_o_falso->check_flight(
     EXPORTING
    iv_carrier_id = lv_carrier_id
    iv_connexion_id = lv_conexion_id
      RECEIVING rv_result = data(lv_bool) ).

* "otra forma (CORREGIR, DA ERROR)
* data(lv_bool) = Lo_verdadero_o_falso->check_flight( EXPORTING
*        iv_carrier_id = 'AA'
*        iv_connexion_id = '0018' ).


      out->write( lv_bool ).

"--------ejercicio 7. ver clase zcl_lab_06_elements_jpf ------------

DATA(go_elements) = NEW zcl_lab_06_elements_jpf( ).
    DATA gs_object TYPE zcl_lab_06_elements_jpf=>ty_elem_objects.

    gs_object-class     = 'ABAP_CLASS'.
    gs_object-instance  = 'INSTANCE 123'.
    gs_object-reference = 'GO_ELEMENTS'.

    go_elements->set_object( exporting is_object = gs_object ).

    out->write( go_elements->ms_object ).

  ENDMETHOD.
ENDCLASS.
