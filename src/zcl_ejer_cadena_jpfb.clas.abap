CLASS zcl_ejer_cadena_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer_cadena_jpfb IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.



*1.Eliminar los espacios sobrantes de la frase.
*2. Convertir la frase a minúsculas.
*3.Comprobar si la palabra "abap" aparece en ella.
*4. Si aparece, extraer solo esa palabra usando substring_from.
*5. Contar cuántos caracteres tiene la frase sin espacios iniciales/finales.
*6. Mostrar todos los resultados por consola.


DATA lv_texto type string value '¡   Bienvenido a   ABAP Cloud, Daniel!   '.

*SOLUCIÓN

lv_texto = condense( lv_texto ). "elimino espacio sobrantes modificando la variable
out->write( lv_texto ). "muestro la variable sin espacios sobrantes
CONSTANTS lc_buscar TYPE string VALUE 'abap'.


lv_texto = to_lower( lv_texto ). "convierte a minúsculas la cadena
out->write( lv_texto ). "muestro la variable en minúsculas

IF count( val = lv_texto sub = lc_buscar ) >= 1. "si se encuentra 'abap' dentro de la cadena una o más veces...
out->write( |Se ha encontrado la palabra: { lc_buscar } | ).

DATA lv_auxiliar_texto type string. "creo una variable en la que hacer la extracción

Lv_auxiliar_texto = substring_from( val =  lv_texto sub = lc_buscar ). "obtiene el texto a partir de la palabra

lv_auxiliar_texto = substring_to( val = lv_auxiliar_texto sub = lc_buscar ). "recorta lo que haya después de la palabra

out->write( |extracción de palabra: { Lv_auxiliar_texto } | ). "muestra la palabra extraida

ELSE.

out->write( |No se encuentea la palabra { lc_buscar } | ).


ENDIF.

out->write( |Caracteres en la frase: { strlen( lv_texto ) }| ).




ENDMETHOD.


ENDCLASS.

