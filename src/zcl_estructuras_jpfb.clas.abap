CLASS zcl_estructuras_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ESTRUCTURAS_JPFB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*TRY CATCH

    TRY.
        DATA: lv_num  TYPE i VALUE 10,
              lv_num2 TYPE i VALUE 0,
              lv_res  TYPE f.

        lv_res = lv_num / lv_num2.
        out->write(  lv_res ).

      CATCH cx_sy_zerodivide INTO DATA(lv_zero_divide).

        out->write( 'ERROR: no se puede efectuar esta operación' ).

    ENDTRY.

*ESTRUCTURA




    " Tipos de tablas:

    "1-TABLAS INTERNAS ( en memoria) Se usan dentro del codigo ABAP !SOLO EXISTEN EN TIEMPO DE EJECUCION¡
    "y las creamos nosotros, no estan en la base de datos.  se declaran como lt_xxxx
    "2-TABLAS DE BASE DE DATOS(persistentes) o tablas transparentes o externas.
    "se crean en el diccionario ABAP (.ddls, .ddic ) y alamacenan datos reales.
    "3-CDS table (o Entity) es una vista avanzada que se define con el lenguaje DDL, en Eclipse, sobre una o varias tablas
    "exsitentes.

    "forma 1 declaracion de estructura
    "declaracion del tipo para la estructura
    TYPES: BEGIN OF ty_persona, "ty_persona: seria el nombre creado para nuestro nuevo tipo

             nombre TYPE char40,
             edad   TYPE numc3,
             email  TYPE /dmo/email_address,

           END OF ty_persona.

*TYPES: BEGIN OF ty_persona2, "ty_persona: seria el nombre creado para nuestro nuevo tipo
*
*             nombre TYPE ty-persona-nombre, " también se puede hacer referencia a una estructura interna
*             edad   TYPE numc3,
*             email  TYPE /dmo/email_address,
*
*           END OF ty_persona2.



    DATA ls_persona TYPE ty_persona. "declaracion de la estructura en si misma

    ls_persona-nombre = 'Pedro'.
    ls_persona-edad = 20.
    ls_persona-email = 'daniel.elviraruiz@experis.es'.


    out->write( ls_persona ).
    out->write( |\n| ).

    """""""""""""""""""""""""""""""""""""""""""""""""""
    "forma 2 declaracion de una estructura


    DATA(ls_persona2) = VALUE ty_persona( nombre = 'Daniel' edad = 20 email = 'daniel.elviraruiz@experis.es' ).



    out->write( ls_persona2 ).


    """""""""""""""""""""""""
    "forma 3 declaracion de una estructura y tipo DE GOLPE.


    DATA: BEGIN OF ls_empleado,
            nombre TYPE string VALUE 'Laura',
            id     TYPE i,
            email  TYPE  /dmo/email_address,
          END OF ls_empleado.







    out->write( |\n| ).
    out->write( ls_empleado ).




    "TIPOS DE ESTRUCTURAS

    "estructura simple
    DATA: BEGIN OF ls_empleado2,
            nombre TYPE string VALUE 'Laura',
            id     TYPE i,
            email  TYPE  /dmo/email_address,
          END OF ls_empleado2.

"estructura anidada

    DATA:BEGIN OF ls_empl_info,

           BEGIN OF info,
             id       TYPE i VALUE 1234,
             nombre   TYPE string VALUE 'Pedro',
             apellido TYPE string VALUE  'Elvira',
           END OF info,

           BEGIN OF direccion,
             ciudad TYPE string VALUE 'Madrid',
             calle  TYPE string VALUE 'c. norfeo',
             pais   TYPE string VALUE  'España',
           END OF direccion,

           BEGIN OF puesto,
             departamento TYPE string VALUE 'IT',
             sueldo       TYPE p DECIMALS 2 VALUE '2000.20',

           END OF puesto,

         END OF ls_empl_info.

out->write( ls_empl_info ).    " para imprimir todo el contenido de la estructura
out->write( ls_empl_info-direccion-calle ).  " para imprimir un unico campo de la estructura
out->write( data = ls_empl_info name = 'informacion de empleado'). " para imprimir toda la estructura con un mensaje informativo.


"estructura profunda


    TYPES: BEGIN OF ty_flights,
             flight_date   TYPE /dmo/flight-flight_date,
             price         TYPE /dmo/flight-price,
             currency_code TYPE /dmo/flight-currency_code,
           END OF ty_flights.


DATA: BEGIN OF ls_flight_info,
      carrier type /dmo/flight-carrier_id VALUE 'AA',
      connid type /dmo/flight-connection_id value '0018',
      lt_flights type table of ty_flights WITH EMPTY KEY , " hace referencia tanto al tipo creado en el types "ty_flights como a la tabla de base de datos

      end of LS_FLIGHT_INFO.



SELECT *
from /dmo/flight
where carrier_id = 'AA'
into corresponding fields of table @ls_flight_info-lt_flights.


out->write( data = ls_flight_info name = 'ls_flight_info').

      endmethod.
ENDCLASS.
