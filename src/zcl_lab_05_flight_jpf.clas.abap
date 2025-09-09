"Crea la clase ZCL_LAB_05_FLIGHT con un método funcional que devuelve
"VERDAD (X) o FALSO (space) en cuanto le pasemos el código de la compañía
"aérea y un número de conexión de vuelo. La comprobación se debe hacer
"con la tabla de base de datos /DMO/FLIGHT.
"Instancia e invoca el método funcional desde la clase de ejecución.

"en la clase main  zcl_lab_01_ejec_jpf se crea el objeto y se hace la exportación
"dandoles valores.

CLASS zcl_lab_05_flight_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

"declaración de métodos
    METHODS check_flight IMPORTING iv_carrier_id    TYPE string
                                   iv_connexion_id  TYPE i
                         RETURNING VALUE(rv_result) TYPE abap_bool.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_05_flight_jpf IMPLEMENTATION.

  METHOD check_flight.

    "intentamos buscar valores para el carrier_id y connexion_id que nos llega por IMPORTING
    SELECT SINGLE FROM /dmo/flight
    FIELDS carrier_id
    WHERE carrier_id = @iv_carrier_id
    AND connection_id = @iv_connexion_id
    INTO @DATA(lv_comp_name).

    "comprobamos si se han encontrado valores. en caso afirmativo se devuelve
    "un boleano a traves del returning value
    IF sy-subrc = 0.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.

   ENDMETHOD.

ENDCLASS.
