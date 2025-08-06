CLASS zcl_tablas_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_tablas_jpfb IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    TYPES: BEGIN OF ty_persona, "crear un tipo para la estructura
*            nombre TYPE string,
*            edad TYPE i,
*          END OF ty_persona.
*
*          TYPES: Ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY. "crea un tipo para la tabla
*
*DATA: lt_personas type ty_tabla_personas, "crea la tabla asignándoles un tipo
*      ls_persona type ty_persona. "crea la estructura asignandole un tipo
*
*      ls_persona-nombre = 'Carlos'.
*      ls_persona-edad = 40.
*
*INSERT ls_persona into Lt_personas INDEX 1. "inserta lo que tengas en la estructura en esta tabla, en la fila 1.
*
*       ls_persona-nombre = 'Maria'. "damos otra vez valores a la estructura
*      ls_persona-edad = 30.
*
*INSERT ls_persona into Lt_personas INDEX 2. "insertamos en la línea 2
*"etc
*
*LOOP AT lt_personas into ls_persona. "bucle para imprimir todas las líneas
*out->write( |Nombre: { ls_persona-nombre }, edad { ls_persona-edad } | ).
*
*ENDLOOP.

*out->write( lt_personas ). "fuera del loop lo presenta en columnas

    "INSERT VALUE

*DATA lt_aeropuerto type STANDARD TABLE OF /dmo/airport.
*insert value #(
*client = 100
*airport_id = 'FRA'
*name = 'Frankfurt Airport'
*city = 'Frankfurt/Main'
*country = 'DE'
*) INTO TABLE lt_aeropuerto.
*
*out->write( lt_aeropuerto ).


    "Si queremos enviarlo a una posición en concreto INTO lt_aeropuerto index 1

    "para poner una línea en blanco

*insert initial line into table lt_aeropuerto.
*
*"para igualar dos tablas internas usamos el like
*
*DATA lt_aeropuerto2 like Lt_aeropuerto. " la tabla aeropuerto 2 será igual a la lt_aeropuerto
* "(no copia los datos de los campos)
*
*"duplicar el contenido
*
**insert lines of lt_aeropuerto into table lt_aeropuerto2.
*
**insert lines of lt_aeropuerto to 2 into table lt_aeropuerto2. "hasta el segundo registro
*
*insert lines of lt_aeropuerto from 2 to 3 into table lt_aeropuerto2. "del segundo al tercero
*
*out->write( data = lt_aeropuerto name = 'Lt_aeropuerto2' ).
*
*
*"añadir registros con APPEND (sólo funciona en tablas standard)
*
    TYPES: BEGIN OF ty_personas, "crear un tipo para la estructura
             nombre TYPE string,
             edad   TYPE i,
           END OF ty_personas.



*DATA: lt_personas TYPE ty_tabla_personas,
*ls_persona TYPE ty_persona.
*
*ls_perspna-nombre = 'Saniel'.
*ls_persona-edad = '23'.
*
*APPEND ls_persona   TO lt_personas.
*
*out->write(  lt_personas ).




*****EJERCICIO
*Una biblioteca quiere guardar información sobre los libros que tiene. Para ello, crea un programa que:
*Defina un tipo de estructura ty_libro con estos campos:
*Título (tipo string)
*Autor (tipo string)
*Número de páginas (tipo i)
*Declare una tabla interna lt_libros y una variable ls_libro de ese tipo.
*Añada tres libros usando INSERT ... INDEX para colocarlos en posiciones concretas.
*Recorra la tabla con un LOOP AT  muestre:
*"Libro corto: <título>" si tiene menos de 150 páginas
*"Libro largo: <título>" si tiene más de 500 páginas
*"Libro estándar: <título>" en otro caso
*Finalmente, muestra toda la tabla con out->write.


    TYPES:BEGIN OF ty_libro,
            titulo            TYPE string,
            autor             TYPE string,
            numero_de_paginas TYPE i,

          END OF ty_libro.


    TYPES: Ty_tabla_libros TYPE STANDARD TABLE OF ty_libro WITH EMPTY KEY.

    DATA: lt_libros TYPE ty_tabla_libros, "crea tabla
          ls_libro  TYPE ty_libro.



    ls_libro = VALUE #( titulo = 'El Quijote' autor =  'Cervantes' numero_de_paginas = 2000 ).

    INSERT ls_libro INTO Lt_libros INDEX 1.


    ls_libro = VALUE #( titulo = 'Aprender Toki Pona' autor =  'Sonia Kisa' numero_de_paginas = 90 ).

    INSERT ls_libro INTO Lt_libros INDEX 2.

    ls_libro = VALUE #( titulo = 'SAP para Dummies' autor =  'Pepe López' numero_de_paginas = 300 ).

    INSERT ls_libro INTO Lt_libros INDEX 3.


    LOOP AT lt_libros INTO ls_libro.
      IF Ls_libro-numero_de_paginas < 150.
        out->write( |libro corto: { ls_libro-titulo } | ).

      ELSEIF Ls_libro-numero_de_paginas  > 500.
        out->write( |libro largo: { ls_libro-titulo } | ).

      ELSE.
        out->write( |libro estándar: { ls_libro-titulo } | ).

      ENDIF.

    ENDLOOP.

    out->write( |\n| ).
    out->write( |\n| ).

    out->write( data = lt_libros  name = 'Catalogo completo de libros' ).


  ENDMETHOD.

ENDCLASS.

