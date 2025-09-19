CLASS zcl_fill_rentcar_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_fill_rentcar_jpf IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

DELETE FROM ztab_rentcar_jpf.
delete from ztab_rent_jpf.
delete from ztab_cstomer_jpf.


    DATA lt_rentcar TYPE STANDARD TABLE OF ztab_rentcar_jpf WITH EMPTY KEY.
    DATA ls_rentcar TYPE ztab_rentcar_jpf.

    " Car 1
    ls_rentcar-mandt        = 100.
    ls_rentcar-matricula    = 'CAR001'.
    ls_rentcar-marca        = 'TOYOTA'.
    ls_rentcar-modelo       = 'Corolla'.
    ls_rentcar-color        = 'Red'.
    ls_rentcar-motor        = 'VVT-i'.
    ls_rentcar-potencia     = '132.00'.
    ls_rentcar-und_potencia = 'HP'.
    ls_rentcar-combustible  = 'Gasoline'.
    ls_rentcar-consumo      = '6.50'.
    ls_rentcar-puertas      = 4.
    ls_rentcar-precio       = 19000.
    ls_rentcar-moneda  = 'EUR'.
    ls_rentcar-alquilado = 1.
    ls_rentcar-alq_desde = '20250513'.
    ls_rentcar-alq_hasta  = '20250607'.
    APPEND ls_rentcar TO lt_rentcar.

    " Car 2
    CLEAR ls_rentcar.
    ls_rentcar-mandt        = 100.
    ls_rentcar-matricula    = 'CAR002'.
    ls_rentcar-marca        = 'FORD'.
    ls_rentcar-modelo       = 'Focus'.
    ls_rentcar-color        = 'Blue'.
    ls_rentcar-motor        = 'EcoBoost'.
    ls_rentcar-potencia     = '150.00'.
    ls_rentcar-und_potencia = 'HP'.
    ls_rentcar-combustible  = 'Diesel'.
    ls_rentcar-consumo      = '5.80'.
    ls_rentcar-puertas      = 5.
      ls_rentcar-precio       = 20000.
    ls_rentcar-moneda  = 'EUR'.
    ls_rentcar-alquilado = 1.
    ls_rentcar-alq_desde = '20250213'.
    ls_rentcar-alq_hasta  = '20250714'.

    APPEND ls_rentcar TO lt_rentcar.

    " Car 3
    CLEAR ls_rentcar.
    ls_rentcar-mandt        = 100.
    ls_rentcar-matricula    = 'CAR003'.
    ls_rentcar-marca        = 'BMW'.
    ls_rentcar-modelo       = '320i'.
    ls_rentcar-color        = 'Black'.
    ls_rentcar-motor        = 'TwinPower Turbo'.
    ls_rentcar-potencia     = '184.00'.
    ls_rentcar-und_potencia = 'HP'.
    ls_rentcar-combustible  = 'Petrol'.
    ls_rentcar-consumo      = '7.20'.
    ls_rentcar-puertas      = 4.
    ls_rentcar-precio       = 28000.
    ls_rentcar-moneda  = 'EUR'.
    ls_rentcar-alquilado = 0.
    ls_rentcar-alq_desde = 0.
    ls_rentcar-alq_hasta  = 0.
    APPEND ls_rentcar TO lt_rentcar.

    " Car 4
    CLEAR ls_rentcar.
    ls_rentcar-mandt        = 100.
    ls_rentcar-matricula    = 'CAR004'.
    ls_rentcar-marca        = 'TESLA'.
    ls_rentcar-modelo       = 'Model 3'.
    ls_rentcar-color        = 'White'.
    ls_rentcar-motor        = 'Electric Drive'.
    ls_rentcar-potencia     = '283.00'.
    ls_rentcar-und_potencia = 'HP'.
    ls_rentcar-combustible  = 'Electric'.
    ls_rentcar-consumo      = '0.00'.
    ls_rentcar-puertas      = 4.
        ls_rentcar-precio       = 40000.
    ls_rentcar-moneda  = 'EUR'.
    ls_rentcar-alquilado = 1.
    ls_rentcar-alq_desde = '20250215'.
    ls_rentcar-alq_hasta  = '20250707'.
    APPEND ls_rentcar TO lt_rentcar.

    " Car 5
    CLEAR ls_rentcar.
    ls_rentcar-mandt        = 100.
    ls_rentcar-matricula    = 'CAR005'.
    ls_rentcar-marca        = 'HONDA'.
    ls_rentcar-modelo       = 'Civic'.
    ls_rentcar-color        = 'Silver'.
    ls_rentcar-motor        = 'i-VTEC'.
    ls_rentcar-potencia     = '158.00'.
    ls_rentcar-und_potencia = 'HP'.
    ls_rentcar-combustible  = 'Gasoline'.
    ls_rentcar-consumo      = '6.00'.
    ls_rentcar-puertas      = 4.
        ls_rentcar-precio       = 23000.
    ls_rentcar-moneda  = 'EUR'.
    ls_rentcar-alquilado = 1.
    ls_rentcar-alq_desde = '20250911'.
    ls_rentcar-alq_hasta  = 0.
    APPEND ls_rentcar TO lt_rentcar.

    " Insert all records
    INSERT ztab_rentcar_jpf FROM TABLE @lt_rentcar.

    IF sy-subrc = 0.
   out->write( 'All 5 car records inserted successfully' ).
    ELSE.
  out->write( 'Error inserting car records' ).

ENDIF.

  "-------------------------------------------------

DATA: lt_rent TYPE STANDARD TABLE OF ztab_rent_jpf WITH EMPTY KEY,
      ls_rent TYPE ztab_rent_jpf.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'TOYOTA'.
ls_rent-url   = 'https://www.toyota.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'FORD'.
ls_rent-url   = 'https://www.ford.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'BMW'.
ls_rent-url   = 'https://www.bmw.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'TESLA'.
ls_rent-url   = 'https://www.tesla.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'HONDA'.
ls_rent-url   = 'https://www.honda.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'AUDI'.
ls_rent-url   = 'https://www.audi.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'MERCEDES'.
ls_rent-url   = 'https://www.mercedes-benz.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'VOLKSWAGEN'.
ls_rent-url   = 'https://www.vw.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'SEAT'.
ls_rent-url   = 'https://www.seat.com'.
APPEND ls_rent TO lt_rent.

CLEAR ls_rent.
ls_rent-mandt = 100.
ls_rent-marca = 'RENAULT'.
ls_rent-url   = 'https://www.renault.com'.
APPEND ls_rent TO lt_rent.

INSERT ztab_rent_jpf FROM TABLE @lt_rent.

COMMIT WORK.
""-----------------

DATA: lt_customer TYPE STANDARD TABLE OF ztab_cstomer_jpf WITH EMPTY KEY,
      ls_customer TYPE ztab_cstomer_jpf.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00001'.
ls_customer-matricula    = 'CAR001'.
ls_customer-fecha_inicio = '20250901'.
ls_customer-fecha_fin    = '20250910'.
ls_customer-nombres      = 'Carlos'.
ls_customer-apellidos    = 'García López'.
ls_customer-email        = 'carlos.garcia@example.com'.
ls_customer-cntr_type    = 'TEMP'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00002'.
ls_customer-matricula    = 'CAR002'.
ls_customer-fecha_inicio = '20250815'.
ls_customer-fecha_fin    = '20250825'.
ls_customer-nombres      = 'María'.
ls_customer-apellidos    = 'Fernández Ruiz'.
ls_customer-email        = 'maria.fernandez@example.com'.
ls_customer-cntr_type    = 'FULL'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00003'.
ls_customer-matricula    = 'CAR003'.
ls_customer-fecha_inicio = '20250710'.
ls_customer-fecha_fin    = '20250720'.
ls_customer-nombres      = 'Luis'.
ls_customer-apellidos    = 'Martínez Pérez'.
ls_customer-email        = 'luis.martinez@example.com'.
ls_customer-cntr_type    = 'TEMP'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00004'.
ls_customer-matricula    = 'CAR004'.
ls_customer-fecha_inicio = '20250601'.
ls_customer-fecha_fin    = '20250615'.
ls_customer-nombres      = 'Ana'.
ls_customer-apellidos    = 'Sánchez Gómez'.
ls_customer-email        = 'ana.sanchez@example.com'.
ls_customer-cntr_type    = 'FULL'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00005'.
ls_customer-matricula    = 'CAR005'.
ls_customer-fecha_inicio = '20250520'.
ls_customer-fecha_fin    = '20250530'.
ls_customer-nombres      = 'Javier'.
ls_customer-apellidos    = 'Torres Díaz'.
ls_customer-email        = 'javier.torres@example.com'.
ls_customer-cntr_type    = 'TEMP'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00006'.
ls_customer-matricula    = 'CAR006'.
ls_customer-fecha_inicio = '20250410'.
ls_customer-fecha_fin    = '20250420'.
ls_customer-nombres      = 'Lucía'.
ls_customer-apellidos    = 'Ramírez Soto'.
ls_customer-email        = 'lucia.ramirez@example.com'.
ls_customer-cntr_type    = 'FULL'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00007'.
ls_customer-matricula    = 'CAR007'.
ls_customer-fecha_inicio = '20250301'.
ls_customer-fecha_fin    = '20250310'.
ls_customer-nombres      = 'Miguel'.
ls_customer-apellidos    = 'Navarro León'.
ls_customer-email        = 'miguel.navarro@example.com'.
ls_customer-cntr_type    = 'TEMP'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00008'.
ls_customer-matricula    = 'CAR008'.
ls_customer-fecha_inicio = '20250215'.
ls_customer-fecha_fin    = '20250225'.
ls_customer-nombres      = 'Laura'.
ls_customer-apellidos    = 'Molina Cruz'.
ls_customer-email        = 'laura.molina@example.com'.
ls_customer-cntr_type    = 'FULL'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00009'.
ls_customer-matricula    = 'CAR009'.
ls_customer-fecha_inicio = '20250105'.
ls_customer-fecha_fin    = '20250115'.
ls_customer-nombres      = 'Pedro'.
ls_customer-apellidos    = 'Ortega Vázquez'.
ls_customer-email        = 'pedro.ortega@example.com'.
ls_customer-cntr_type    = 'TEMP'.
APPEND ls_customer TO lt_customer.

CLEAR ls_customer.
ls_customer-mandt        = '100'.
ls_customer-doc_id       = 'DNI00010'.
ls_customer-matricula    = 'CAR010'.
ls_customer-fecha_inicio = '20250910'.
ls_customer-fecha_fin    = '20250919'.
ls_customer-nombres      = 'Sofía'.
ls_customer-apellidos    = 'Delgado Romero'.
ls_customer-email        = 'sofia.delgado@example.com'.
ls_customer-cntr_type    = 'FULL'.
APPEND ls_customer TO lt_customer.

INSERT ztab_cstomer_jpf FROM TABLE @lt_customer.

  ENDMETHOD.

ENDCLASS.


