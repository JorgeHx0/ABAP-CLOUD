CLASS zcl_ejercicio_do_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EJERCICIO_DO_JPFB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*PARTE 1.
*Extraer de la siguiente variable   DATA(lv_string) = 'danielFernando Pedro ramonSergio’.
*los distintos nombres que hay su interior y almacenar cada nombre en variables independientes.



    " Declaramos la cadena original con los nombres separados por espacios
    DATA(lv_string) = 'daniel Fernando Pedro ramon Sergio'.

    " Quitamos espacios duplicados y espacios al principio/final si los hubiera
    CONDENSE lv_string."""""""""""""""" lo mismo con funcion split"""""""""""""""""""""""""
    DATA: lv_nombre1 TYPE string,
          lv_nombre2 TYPE string,
          lv_nombre3 TYPE string,
          lv_nombre4 TYPE string,
          lv_nombre5 TYPE string.

    " Extraer los nombres usando SPLIT
    SPLIT lv_string AT space  INTO  lv_nombre1 lv_nombre2 lv_nombre3 lv_nombre4 lv_nombre5.

    """""""""""""""""""""""""""""

*PARTE 2.

*-Crear un sistema que:
*  2.1-Identifique si el numero de caracteres de cada variable creada es  mayor a 7 y que en caso         afirmativo, que aparezca por consola un mensaje diciendo “Hola Fernando”,
*  2.2-En caso de ser menor de 7, el programa tendrá que comprobar si el tamaño del nombre es igual a 6.
*  2.3-En caso negativo se deberá escribir por consola un mensaje diciendo “Hola Pedro”  y cambiar el   tipo de caracares del nombre de minúscula a mayúscula.
*  2.4-En caso afirmativo se deberá identificar si el nombre es Sergio o Daniel, en caso del nombre sea Sergio se   escribirá un mensaje que diga “Hola Sergio”  y en caso de ser Daniel otro mensaje que diga “Hola Daniel”.
*
**Solo se podrán usar el condicional IF y las funciones de caracteres que hemos visto en clase, nada de bucles u otros eleméntenos que no se hayan visto en clase .**  PROHIBIDO usar el SPLIT



    DATA: lv_nombre TYPE string.

    DO.

      DATA: lv_repeticion TYPE string.
      lv_repeticion = sy-index.

      CASE lv_repeticion.

        WHEN 1.
          lv_nombre = lv_nombre1.
        WHEN 2.
          lv_nombre = lv_nombre2.
        WHEN 3.
          Lv_nombre = lv_nombre3.
        WHEN 4.
          Lv_nombre = lv_nombre4.
        WHEN 5.
          Lv_nombre = lv_nombre5.
        WHEN 6.
          EXIT.

      ENDCASE.




      " Obtenemos su longitud
      DATA(lv_longitud) = strlen( lv_nombre ).

      " Evaluamos según la longitud del nombre
      IF lv_longitud > 7.
        " Si tiene más de 7 caracteres, asumimos que es Fernando
        out->write( 'Hola Fernando' ).

      ELSEIF lv_longitud = 6.
        " Si tiene 6 caracteres puede ser Sergio o Daniel
        IF lv_nombre = 'Sergio'.
          out->write( 'Hola Sergio' ).
        ELSEIF lv_nombre = 'daniel'.
          out->write( 'Hola Daniel' ).
        ENDIF.

      ELSE.
        " Si no es ninguno de los anteriores, asumimos que es Pedro
        out->write( 'Hola Pedro' ).

        " Convertimos el nombre a mayúsculas
        lv_nombre = to_upper( lv_nombre ).

        " Mostramos el nombre en mayúsculas
        out->write( |Nombre en mayúsculas: { lv_nombre }| ).
      ENDIF.


    ENDDO.



  ENDMETHOD.
ENDCLASS.
