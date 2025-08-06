CLASS zcl_funcionescadena_jpfb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_funcionescadena_jpfb IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.



*
*
*DATA: lv_string TYPE string VALUE 'daniel Fernando Pedro Ramon',
*      lv_name   TYPE string VALUE 'Fernando',
*      lv_comodin TYPE string,
*      lv_num    TYPE i.
*
*" Funciones de búsqueda sobre cadenas de texto
*
** strlen
*lv_num = strlen( lv_string ).                                      " Cuenta el número total de caracteres de la cadena (incluye espacios)
*out->write( lv_num ).
*
*" count
*lv_num = count( val = lv_string sub = lv_name ).                   " Cuenta cuántas veces aparece el valor de lv_name en lv_string
*out->write( lv_num ).
*lv_num = count( val = lv_string sub = 'Fernando' ).                " Hace lo mismo que arriba, pero sin usar la variable lv_name
*out->write( lv_num ).
*
*"count_any_of
*lv_num = count_any_of( val = lv_string sub = lv_name ).            " Cuenta cuántos caracteres de lv_name están presentes en lv_string (aunque no formen la palabra completa)
*out->write( lv_num ).
*
*"count_any_not_of
*lv_num = count_any_not_of( val = lv_string sub = 'Fernando' ).     " Cuenta cuántos caracteres de lv_string **no** están en la palabra 'Fernando'
*out->write( lv_num ).
*
*"find  "Empieza a contar por 0
*lv_num = find( val = lv_string sub = lv_name ).                    " Devuelve la posición donde empieza la palabra 'Fernando' dentro de lv_string (empieza desde 0)
*out->write( lv_num ).
*
*"find_any_of
*lv_num = find_any_of( val = lv_string sub = 'Fernando' ).          " Devuelve la posición del primer carácter que coincida con alguno de los caracteres de 'Fernando'
*out->write( lv_num ).
*
*"find_any_not_of
*lv_num = find_any_not_of( val = lv_string sub = 'Fernando' ).      " Devuelve la posición del primer carácter de lv_string que **no** está contenido en 'Fernando'
*out->write( lv_num ).
*
*
*
*  "funciones de procesamiento
**    DATA: lv_string  TYPE string VALUE 'daniet Fernando Pedro Ramon',
**          lv_comodin TYPE string.
*
*
*" MAYUS minus
*out->write( |TO_UPPER         = { to_upper( lv_string ) } | ).        " Convierte todo el texto a MAYÚSCULAS
*out->write( |TO_LOWER         = { to_lower( lv_string ) } | ).        " Convierte todo el texto a minúsculas
*out->write( |TO_MIXED         = { to_mixed( lv_string ) } | ).        " Primera letra de cada palabra en mayúscula
*out->write( |FROM_MIXED       = { from_mixed( lv_string ) } | ).      " Invierte el efecto de to_mixed (si aplica)
*
*" Order
*out->write( |REVERSE          = { reverse( lv_string ) } | ).         " Invierte el orden de todos los caracteres del texto
*out->write( |SHIFT_LEFT (places)  = { shift_left( val = lv_string places = 5 ) } | ).  " Desplaza 5 caracteres a la izquierda (rellena con espacios)
*out->write( |SHIFT_RIGHT (places) = { shift_right( val = lv_string places = 5 ) } | ). " Desplaza 5 caracteres a la derecha (rellena con espacios)
*out->write( |SHIFT_LEFT (circ)    = { shift_left( val = lv_string circular = 5 ) } | )." Desplaza 5 caracteres a la izquierda de forma circular
*out->write( |SHIFT_RIGHT (circ)   = { shift_right( val = lv_string circular = 5 ) } | )." Desplaza 5 caracteres a la derecha de forma circular
*
*" Substring
*out->write( |SUBSTRING           = { substring( val = lv_string off = 9 len = 6 ) } | ).     " Extrae 6 caracteres desde la posición 9
*out->write( |SUBSTRING_FROM      = { substring_from( val = lv_string sub = 'Pedro' ) } | ).   " Devuelve el texto a partir de 'Pedro' (inclusive)
*out->write( |SUBSTRING_AFTER     = { substring_after( val = lv_string sub = 'Pedro' ) } | ).  " Devuelve el texto después de 'Pedro' (excluyendo 'Pedro')
*out->write( |SUBSTRING_TO        = { substring_to( val = lv_string sub = 'Pedro' ) } | ).     " Devuelve el texto desde el inicio hasta 'Pedro' (inclusive)
*out->write( |SUBSTRING_BEFORE    = { substring_before( val = lv_string sub = 'Pedro' ) } | ). " Devuelve el texto desde el inicio hasta antes de 'Pedro'
*
**" Others
**out->write( |CONDENSE            = { condense( val = lv_string ) } | ).   " Elimina espacios duplicados e innecesarios ( como dobles espacios en blanco)
**out->write( |REPEAT              = { repeat( val = lv_string occ = 2 ) } | ). " Repite el contenido completo 2 veces
**out->write( |SEGMENT1            = { segment( val = lv_string sep = '!' index = 1 ) } | ).    " Extrae el primer segmento antes del primer '!'
**out->write( |SEGMENT2            = { segment( val = lv_string sep = '!' index = 2 ) } | ).    " Extrae el segundo segmento entre el primer y segundo '!'
*
*
    "funciones de contenido


*    DATA: lv_text     TYPE string,
*          lv_pattern  TYPE string,
*          lv_pattern2 TYPE string.

" contains con pcre .
*    lv_text = 'El telefono del empleado es 688-365-987 el correo electronico es daniel.elviraruiz@experis.es'.
*    lv_pattern = `\d{3}-\d{3}-\d{3}`.
*
*    lv_pattern2 = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b`.
*
*    IF contains( val = lv_text pcre = lv_pattern2 ).
*      out->write( 'El texto contiene una direccion de correo electronico ' ).
*      DATA(lv_count) = count( val = lv_text pcre = lv_pattern2 ).
*      out->write( lv_count ).
*      DATA(lv_pos) = find( val = lv_text pcre = lv_pattern2 occ = 1 ).
*      out->write( lv_pos ).
*    ENDIF.
*
*    IF contains(  val = lv_text pcre = lv_pattern ).
*      out->write('el texto contiene un numero de telefono').
*    ELSE.
*
*      out->write('el texto NO contiene un numero de telefono').
*    ENDIF.

" match con pcre

*    lv_text = 'El telefono del empleado es 688-365-987 el correo electronico es daniel.elviraruiz@experis.es'.
*    lv_pattern = `\d{3}-\d{3}-\d{3}`.
*
*    lv_pattern2 = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b`.
*
*    data(lv_numero) = match( val = lv_text pcre = lv_pattern occ = '1').
*      out->write( lv_numero ).

"Concatenación forma 1


*
*DATA: lv_string_a type string VALUE 'hola, que tal esta ? ',
*       lv_string_b type string value 'Bien gracias 2',
*       lv_concatenacion type string,
*       lv_concatenacion3 type string.
*
*lv_concatenacion = |concatenacion 1: { lv_string_a } { lv_string_a } |.
*out->write( lv_concatenacion ).
*
*"concatencion forma 2
*
*    Concatenate lv_string_a lv_string_b into data(lv_concatenacion2)  SEPARATED BY space.
*
*"concatenacion forma 3
*
*lv_concatenacion3 = 'Hola' && ` ` && 'Juan'.
*out->write( lv_concatenacion3 ).
*
*"concatenacion de lineas de tablas.
*SELECT from /dmo/flight
*fields flight_date
*into table @data(lt_itab).
*
*
*DATA(lv_string_itab) = concat_lines_of( table = lt_itab sep = '-' ).
*out->write( lv_string_itab ).
*


*Segment

DATA(lv_string1) ='El-perro-corre-por-el-prado'.
DATA(lv_palabra) = segment( val = lv_string1 index = 3 sep = '-' ). "selecciona el tercer elemento separado por -

out->write( lv_palabra ).

*insert

*DATA(Lv_ins_string) = insert(  val = '123cliente01'  sub = 'INV' off = 3 ).
*out->write(  lv_ins_string )
.
*overlay

DATA(lv_string) = 'a.b.c.a.b.c.A'.
DATA(lv_string2) = 'z.x.y.Z.x.y.z'.

overlay lv_string with lv_string2 only 'ab'.
out->write( lv_string ).

*find ALL OCCURRENCES OF

data: lv_string_c type string VALUE '9ERP ####### El perro corre por el campo'.

find ALL OCCURRENCES OF '#' in lv_string_c match count data(lv_count). "permite varias combinaciones. en este caso se declara una variable en línea

out->write(  lv_count ).

*ejercicio


*1-Extraer de la siguiente variable   DATA(lv_string) = 'danielFernando Pedro ramonSergio’.   losdistintos nombres que hay su interior y almacenar cada nombre en variables independientes.
*
*2-Crear un sistema que:
*  2.1-Identifique si el numero de caracteres de cada variable creada es  mayor a 7 y que en caso         afirmativo, que aparezca por consola un mensaje diciendo “Hola Fernando”,
*  2.2-En caso de ser menor de 7, el programa tendrá que comprobar si el tamaño del nombre es igual a 6.
*  2.3-En caso negativo se deberá escribir por consola un mensaje diciendo “Hola Pedro”  y cambiar el   tipo de caracares del nombre de minúscula a mayúscula.
*  2.4-En caso afirmativo se deberá identificar si el nombre es Sergio o Daniel, en caso del nombre sea Sergio se   escribirá un mensaje que diga “Hola Sergio”  y en caso de ser Daniel otro mensaje que diga “Hola Daniel”.
*
**Solo se podrán usar el condicional IF y las funciones de caracteres que hemos visto en clase, nada de bucles u otros eleméntenos que no se hayan visto en clase .**  PROHIBIDO usar el SPLIT


*parte 1
*
***    " Declaramos la cadena original con los nombres separados por espacios
*  DATA(lv_string) = 'daniel Fernando Pedro ramon Sergio'.
*
*    " Quitamos espacios duplicados y espacios al principio/final si los hubiera
*    CONDENSE lv_string.
*
*    " Declaramos variables para almacenar cada nombre individualmente
*    DATA: lv_nombre1 TYPE string,
*          lv_nombre2 TYPE string,
*          lv_nombre3 TYPE string,
*          lv_nombre4 TYPE string,
*          lv_nombre5 TYPE string.
*
*    " Buscamos la posición del primer espacio
*    DATA(lv_pos1) = find( val = lv_string sub = | | ).
*
*    " Extraemos el primer nombre desde la posición 0 hasta antes del primer espacio
*    lv_nombre1 = substring( val = lv_string off = 0 len = lv_pos1 ).
*
*    " Obtenemos el resto de la cadena después del primer espacio
*    DATA(lv_rest1) = substring_after( val = lv_string sub = | | ).
*
*    " Buscamos el siguiente espacio en la nueva subcadena
*    DATA(lv_pos2) = find( val = lv_rest1 sub = | | ).
*
*    " Extraemos el segundo nombre
*    lv_nombre2 = substring( val = lv_rest1 off = 0 len = lv_pos2 ).
*
*    " Repetimos el proceso para extraer el tercer nombre
*    DATA(lv_rest2) = substring_after( val = lv_rest1 sub = | | ).
*    DATA(lv_pos3) = find( val = lv_rest2 sub = | | ).
*    lv_nombre3 = substring( val = lv_rest2 off = 0 len = lv_pos3 ).
*
*    " Repetimos el proceso para extraer el cuarto nombre
*    DATA(lv_rest3) = substring_after( val = lv_rest2 sub = | | ).
*    DATA(lv_pos4) = find( val = lv_rest3 sub = | | ).
*    lv_nombre4 = substring( val = lv_rest3 off = 0 len = lv_pos4 ).
*
*    " El quinto nombre es lo que queda después del último espacio
*    lv_nombre5 = substring_after( val = lv_rest3 sub = | | ).

"también se puede hacer con split

*DATA(lv_string) = 'daniel Fernando Pedro ramon Sergio'.
*
*DATA:lv_nombre1 TYPE string,
*     lv_nombre2 TYPE string,
*     lv_nombre3 TYPE string,
*     lv_nombre4 TYPE string,
*     lv_nombre5 TYPE string.
*
* SPLIT lv_string AT 'n' INTO lv_nombre1 lv_nombre2 lv_nombre3 lv_nombre4 lv_nombre5.


*parte 2

*   DATA(lv_nombre) = lv_nombre4.
*    DATA: lv_longitud TYPE i.
*
*    lv_longitud = strlen( lv_nombre ).
*
*    IF lv_longitud > 7.
*      out->write( 'Hola Fernando' ).
*
*    ELSEIF lv_longitud = 6.
*      IF lv_nombre = 'Sergio'.
*        out->write( 'Hola Sergio' ).
*      ELSEIF lv_nombre = 'daniel' .
*        out->write( 'Hola Daniel' ).
*      ENDIF.
*
*
*    ELSE.
*      lv_nombre = to_upper( lv_nombre ).
*      out->write( |Hola { lv_nombre } | ).
*
*    ENDIF.

*
*    " Seleccionamos un nombre a evaluar (en este caso, el primero: daniel)
*    DATA(lv_nombre) = lv_nombre4.
*
*    " Obtenemos su longitud
*    DATA(lv_longitud) = strlen( lv_nombre ).
*
*    " Evaluamos según la longitud del nombre
*    IF lv_longitud > 7.
*      " Si tiene más de 7 caracteres, asumimos que es Fernando
*      out->write( 'Hola Fernando' ).
*
*    ELSEIF lv_longitud = 6.
*      " Si tiene 6 caracteres puede ser Sergio o Daniel
*      IF lv_nombre = 'Sergio'.
*        out->write( 'Hola Sergio' ).
*      ELSEIF lv_nombre = 'daniel'.
*        out->write( 'Hola Daniel' ).
*      ENDIF.
*
*
*    ELSE.
*
*      " Convertimos el nombre a mayúsculas
*      lv_nombre = to_upper( lv_nombre ).
*
*      IF lv_nombre = 'PEDRO'.
*        out->write( 'Hola Pedro' ).
*
*  " Mostramos el nombre en mayúsculas
*      out->write( |Nombre en mayúsculas: { lv_nombre }| ).
*
*      ELSEIF lv_nombre = 'RAMON'.
*
*        out->write( 'Hola Ramon ' ).
*
*      ENDIF.
*
*
*
*    ENDIF.


*mi resolución (sin terminar)





*DATA Lv_string type string.
*lv_string = 'daniel Fernando Pedro ramon Sergio'.
*
*DATA lv_fragmento_1 type string.
*DATA lv_fragmento_2 type string.
*DATA lv_fragmento_3 type string.
*DATA lv_fragmento_4 type string.
*DATA lv_fragmento_5 type string.
*
*lv_fragmento_1 = substring_before( val = lv_string sub = ` ` ).
*out->write( lv_fragmento_1 ).
*
*
*lv_string = substring_after( val = lv_string sub = lv_fragmento_1 ).
*
*lv_string = condense( lv_string ).
*
*Lv_fragmento_2 = substring_before( val = lv_string sub = ` ` ).
*out->write( lv_fragmento_2 ).
*
*lv_string = substring_after( val = lv_string sub = lv_fragmento_2 ).
*lv_string = condense( lv_string ).
*
*lv_fragmento_3 = substring_before( val = lv_string sub = ` ` ).
*out->write( lv_fragmento_3 ).
*
*lv_string = substring_after( val = lv_string sub = lv_fragmento_3 ).
*lv_string = condense( lv_string ).
*
*lv_fragmento_4 = substring_before( val = lv_string sub = ` ` ).
*out->write( lv_fragmento_4 ).
*
*lv_string = substring_after( val = lv_string sub = lv_fragmento_4 ).
*lv_string = condense( lv_string ).
*
*lv_fragmento_5 = substring_before( val = lv_string sub = ` ` ).
*out->write( lv_fragmento_5 ).
*
*lv_string = substring_after( val = lv_string sub = lv_fragmento_5 ).
*lv_string = condense( lv_string ).
*
*out->write( lv_string ).




*DATA lv_contar_caracteres type i.
*
*lv_contar_caracteres = strlen( lv_string ).
*
*DATA lv_posicion type i.
*lv_posicion = find_any_of( val = lv_string sub = '`' ).
*
*
*DATA lv_fragmento_1 type string.
*lv_fragmento_1 = substring( val = lv_string off = 1 len = lv_posicion ).
*
*out->write( lv_fragmento_1 ).


  ENDMETHOD.


ENDCLASS.
