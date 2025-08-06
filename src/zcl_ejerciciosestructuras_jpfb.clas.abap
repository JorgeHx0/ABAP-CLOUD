CLASS zcl_ejerciciosestructuras_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_ejerciciosestructuras_jpfb IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*31-7 CREACIÓN DE ESTRUCTURAS

    "método 1. crear primero el tipo y después la estructura

    TYPES: BEGIN OF ty_estructura1,
             nombre          TYPE string,
             dieta           TYPE string,
             numero_de_patas TYPE i,
             color           TYPE string,
             peso_kg         TYPE p LENGTH 6 DECIMALS 2,
           END OF ty_estructura1.

    DATA ls_estructura1 TYPE ty_estructura1.
    ls_estructura1-nombre = 'León'.
    ls_estructura1-dieta = 'carnívoro'.
    Ls_estructura1-numero_de_patas = 4.
    ls_estructura1-color = 'marrón'.
    ls_estructura1-peso_kg = 200.

    out->write( ls_estructura1 ).


    "método 2. declaración en línea.


    TYPES: BEGIN OF ty_estructura2, "declaramos el tipo
          nombre          TYPE string,
          dieta           TYPE string,
          numero_de_patas TYPE i,
          color           TYPE string,
          peso_kg         TYPE p LENGTH 6 DECIMALS 2,
           END OF ty_estructura2.


    DATA(ls_estructura2) = VALUE ty_estructura2(
        nombre = 'cuervo'
        dieta = 'omnívoro'
        numero_de_patas = 2
        color = 'negro'
        peso_kg = 1 ).

    out->write( ls_estructura2 ).


  ENDMETHOD.
ENDCLASS.
