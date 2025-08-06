CLASS zcl_dia_repaso_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_dia_repaso_jpfb IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*EJERCICIOS EXTRA

*Define un tipo de estructura ty_pasajero con los campos:
*no*bre (string)
*edad (i)
*email (/dmo/email_address)
*Declara una tabla interna lt_pasajeros y añade los siguientes pasajeros usando APPEND VALUE:
*Ana, 28 años, ana@viajes.com
*Pedro, 17 años, pedro@viajes.com
*Lucía, 34 años, lucia@viajes.com
*Marcos, 15 años, marcos@viajes.com
*Añade un nuevo pasajero (Carlos, 22 años, carlos@viajes.com) en la segunda posición con INSERT ... INDEX.
*Copia todos los pasajeros a una nueva tabla lt_pasajeros2, pero solo si tienen menos de 30 años.
*Usa READ TABLE ... INDEX para leer el pasajero en la posición 3. Si sy-subrc = 0, muestra su nombre en mayúsculas con TO_UPPER

    TYPES: BEGIN OF ty_pasajero,
             nombre TYPE string,
             edad   TYPE i,
             email  TYPE /dmo/email_address,
           END OF: ty_pasajero.

    TYPES: ty_tabla_pasajeros TYPE STANDARD TABLE OF ty_pasajero WITH EMPTY KEY.

    DATA: lt_pasajeros TYPE ty_tabla_pasajeros,
          ls_pasajeros TYPE ty_pasajero.

    ls_pasajeros = VALUE #( nombre = 'Ana' edad = 28 email = 'ana@viajes.com' ).
    APPEND ls_pasajeros TO lt_pasajeros.

    ls_pasajeros = VALUE #( nombre = 'Pedro' edad = 17 email = 'pedro@viajes.com' ).
    APPEND ls_pasajeros TO lt_pasajeros.

    ls_pasajeros = VALUE #( nombre = 'Lucía' edad = 34 email = 'lucia@viajes.com' ).
    APPEND ls_pasajeros TO lt_pasajeros.

    ls_pasajeros = VALUE #( nombre = 'Marcos' edad = 15 email = 'marcos@viajes.com' ).
    APPEND ls_pasajeros TO lt_pasajeros.

"añadimos a Carlos en 2a posición
ls_pasajeros-nombre = 'Carlos'.
ls_pasajeros-edad = 22.
ls_pasajeros-email = 'carlos@viajes.com'.

INSERT ls_pasajeros INTO lt_pasajeros INDEX 2.

"Nueva tabla

DATA: lt_pasajeros2 TYPE ty_tabla_pasajeros,
ls_pasajeros2 TYPE ty_pasajero.


LOOP AT lt_pasajeros INTO ls_pasajeros.

*out->write( sy-tabix ). " para ver el índice
IF ls_pasajeros-edad < 30.
INSERT ls_pasajeros INTO lt_pasajeros2 INDEX 1.
endif.

ENDLOOP.

 out->write( lt_pasajeros2 ).


*PARTE 2
*Rellena manualmente una tabla lt_aeropuertos con 3 registros de la tabla /dmo/airport usando INSERT VALUE #( ... ):
*FRA, Frankfurt, DE
*MUC, Munich, DE
*BCN, Barcelona, ES
*Copia solo los aeropuertos alemanes (country = 'DE') a una nueva tabla lt_alemanes, usando un LOOP AT con condición.
*Accede al aeropuerto con airport_id = 'MUC' usando la forma moderna de READ TABLE y muestra solo el campo city.

TYPES: BEGIN OF ty_aeropuertos,
       client TYPE /dmo/airport-client,
       airport_id TYPE /dmo/airport-airport_id,
       name TYPE /dmo/airport-name,
       city TYPE /dmo/airport-city,
       country TYPE /dmo/airport-country,
       end of ty_aeropuertos.

       TYPES: ty_tabla_aeropuertos TYPE STANDARD TABLE OF ty_aeropuertos WITH EMPTY KEY.

DATA: lt_aeropuertos TYPE ty_tabla_aeropuertos,
      ls_aeropuertos TYPE ty_aeropuertos.


*otra forma
*DATA lt_alemanes TYPE STANDARD TABLE OF /dmo/airport.
*DATA ls_aeropuerto TYPE /dmo/airport.

*o también
*DATA: lt_aeropuertos TYPE STANDARD TABLE OF /dmo/airport WITH EMPTY KEY.

INSERT VALUE #( airport_id = 'FRA' city = 'Frankfurt' country = 'DE' ) INTO TABLE lt_aeropuertos.
INSERT VALUE #( AIRPORT_ID = 'MUC' CITY = 'Munich' COUNTRY = 'DE' ) INTO TABLE lt_aeropuertos.
INSERT VALUE #( AIRPORT_ID = 'BCN' CITY = 'Barcelona' COUNTRY = 'ES' ) INTO TABLE lt_aeropuertos.

out->write( lt_aeropuertos ).

data: lt_alemanes type ty_tabla_aeropuertos.

LOOP AT lt_aeropuertos INTO ls_aeropuertos.
if ls_aeropuertos-country = 'DE'.
APPEND ls_aeropuertos TO lt_alemanes.

endif.
ENDLOOP.

out->write( lt_alemanes ).

DATA(ls_aeropuertos2) = lt_aeropuertos[ airport_id = 'MUC' ]-city.
out->write( ls_aeropuertos2 ).


*💬 PARTE 3 – FUNCIONES DE TEXTO
*Declara una variable lv_texto con el siguiente contenido:
*'El pasajero Pedro con email pedro@viajes.com ha comprado el billete'.
*Extrae:
*El nombre del pasajero con substring_between usando "pasajero " y " con".
*El correo electrónico usando expresión regular (\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b) y la función match.
*Reemplaza el nombre del pasajero por 'XXXXX' con replace.

data(lv_texto) = 'El pasajero Pedro con email pedro@viajes.com ha comprado el billete'.

data lv_pasajero TYPE string.
lv_pasajero = substring_after( val = lv_texto sub = 'pasajero' ).
lv_pasajero = substring_before( val = lv_pasajero sub = 'con' ).
lv_pasajero = condense( val = lv_pasajero ).
out->write( |nombre del pasajero: { lv_pasajero } | ).

*solución profe parte 3
*9. Texto de entrada
*    DATA(lv_texto) = 'El pasajero Pedro con email pedro@viajes.com ha comprado el billete'.
*
*    " 10. Extraer nombre del pasajero entre "pasajero " y " con"
*    DATA(lv_temp) = substring_after( val = lv_texto sub = 'pasajero ' ).
*    DATA(lv_nombre) = substring_before( val = lv_temp sub = ' con' ).
*
*    out->write( |Nombre extraído: { lv_nombre }| ).
*
*    " Extraer el email con expresión regular usando MATCH
*    DATA(lv_pattern_email) = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b`.
*    DATA(lv_email) = match( val = lv_texto pcre = lv_pattern_email occ = '1' ).
*
*    out->write( |Email extraído: { lv_email }| ).
*
*    " 11. Reemplazar el nombre por 'XXXXX'
*    DATA(lv_texto_oculto) = replace( val = lv_texto sub = lv_nombre with = 'XXXXX' ).
*    out->write( |Texto con nombre oculto: { lv_texto_oculto }| ).


*PARTE BONUS

*Concatenar los nombres de todos los pasajeros de la tabla lt_pasajeros2
*en una sola cadena separados por coma, y mostrarla con out->write

out->write( lt_pasajeros2 ).

  ENDMETHOD.

ENDCLASS.
