CLASS zcl_ejercicios_tablas_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_ejercicios_tablas_jpfb IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

"EJERCICIO 1
"Crea una tabla interna con los datos de 15 vuelos simulados. Cada vuelo tendrá:
"Un ID de usuario (iduser)
"Un código de aerolínea (aircode)
"Un número de vuelo (flightnum)
"Una clave de país (key)
"Número de asientos ocupados (seat)
"Fecha del vuelo (flightdate)
"Utiliza una expresión FOR con UNTIL para crear los datos dinámicamente.


"EJER 2
"Con la tabla de vuelos del ejercicio anterior, elimina todos los vuelos
"cuyo número de vuelo sea menor que '0405'.


"EJER 3
"Actualiza la tabla interna lt_flights para:
"Cambiar la aircode a 'UPD' si seat es mayor a 20.
"Cambiar el flightdate al día actual para esos mismos vuelos.

"EJER 4
"Crea dos tablas internas:
"lt_vuelos: contiene información de vuelos (aerolínea, número de vuelo y fecha).
"lt_precios: contiene información de precios de vuelo por aerolínea y número de vuelo.
"Crea una tercera tabla lt_resultado que combine los datos de ambas, solo si coinciden en aircode y flightnum.
"Usa una expresión VALUE #( FOR ... FOR ... ) (for anidado) para construir la tabla resultado.

"Tipos y datos simulados:

TYPES: BEGIN OF ty_vuelo,
         aircode    TYPE /dmo/carrier_id,
         flightnum  TYPE /dmo/connection_id,
         flightdate TYPE /dmo/flight_date,
       END OF ty_vuelo.

TYPES: BEGIN OF ty_precio,
         aircode     TYPE /dmo/carrier_id,
         flightnum   TYPE /dmo/connection_id,
         flightprice TYPE /dmo/flight_price,
         currency    TYPE /dmo/currency_code,
       END OF ty_precio.

TYPES: BEGIN OF ty_resultado,
         aircode     TYPE /dmo/carrier_id,
         flightnum   TYPE /dmo/connection_id,
         flightdate  TYPE /dmo/flight_date,
         flightprice TYPE /dmo/flight_price,
         currency    TYPE /dmo/currency_code,
       END OF ty_resultado.

DATA: lt_vuelos     TYPE STANDARD TABLE OF ty_vuelo,
      lt_precios    TYPE STANDARD TABLE OF ty_precio,
      lt_resultado  TYPE STANDARD TABLE OF ty_resultado.


      "solución ejer 4:


   """"""""""2
   "EJERCICIO
"Crea un programa que muestre solo los vuelos cuya fecha (flight_date) esté dentro de un rango de fechas específico, usando tablas de rangos.
"Pasos que debe cumplir:
"Declarar una tabla de rangos para flight_date.
"Añadir dos condiciones al rango:
"Fechas entre '2025-01-01' y '2025-12-31'.
"Excluir la fecha '2025-06-01'.
"Usar la tabla de rangos en un SELECT sobre /dmo/flight.
"Mostrar el carrier_id, connection_id y flight_date de los vuelos que cumplan.

" 1) Declarar la tabla de rangos para flight_date
DATA lr_dates TYPE RANGE OF /dmo/flight_date.



" 2) Añadir condición: vuelos entre el 1 de enero y el 31 de diciembre de 2025
APPEND VALUE #(
  sign   = 'I'        " Incluir
  option = 'BT'       " Between
  low    = '20250101' " Fecha inicial (AAAAMMDD)
  high   = '20251231' " Fecha final
) TO lr_dates.

" 3) Añadir condición: excluir vuelos del 1 de junio de 2025
APPEND VALUE #(
  sign   = 'E'        " Excluir
  option = 'EQ'       " Igual a
  low    = '20250601' " Fecha a excluir
) TO lr_dates.

" 4) Declarar tabla para guardar resultados
DATA lt_flights TYPE TABLE OF /dmo/flight WITH EMPTY KEY.

" 5) SELECT usando la tabla de rangos
SELECT *
  FROM /dmo/flight
  WHERE flight_date IN @lr_dates
  INTO TABLE @lt_flights.

" 6) Mostrar resultados
LOOP AT lt_flights INTO DATA(ls_flight).
  out->write(
    |Carrier: { ls_flight-carrier_id }  Conn: { ls_flight-connection_id }  Fecha: { ls_flight-flight_date }|
  ).
ENDLOOP.






endmethod.

ENDCLASS.
