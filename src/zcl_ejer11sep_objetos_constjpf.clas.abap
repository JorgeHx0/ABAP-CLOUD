"Clase creadora para zcl_ejer11sep_objetos_main_jpf

CLASS zcl_ejer11sep_objetos_constjpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

     METHODS constructor IMPORTING iv_Nombre          TYPE zde_nombre_jpf
                                  iv_Apellido        TYPE zde_apellido_jpf
                                  iv_telefono        TYPE zde_numero_telefono_jpf
                                  iv_experiencia     TYPE i
                                  iv_certificaciones TYPE i.

    "calcula el ID del empleado y lo lleva a la estructura
    METHODS ex_id_empleado.

     "calcula el sueldo a partir de la experiencia y certificaciones
    METHODS calcular_sueldo.

    "añadir un empleado a la BD, produciendo un mensaje.
    "es el método que se invoca en Main ( zcl_ejer11sep_objetos_main_jpf )
     METHODS alta_empleado RETURNING VALUE(rv_mensaje) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.

 "creamos una estructura donde montar cada línea que va a ir a la BD,
 "usando el mismo tipo de la tabla
    DATA ls_estructura TYPE ztab_eje_obj_jpf.

 "creamos variables donde almacenar los datos que necesitamos para el cálculo del salario
    DATA: experiencia     TYPE i,
          certificaciones TYPE i.
 ENDCLASS.



CLASS zcl_ejer11sep_objetos_constjpf IMPLEMENTATION.

 METHOD constructor.
  "llevamos los datos importados con el constructor a donde se necesitan.
 "para el currency_code no importamos, pero como el dato siempre es igual,
 "se mete literalmente
    me->ls_estructura-nombre = iv_Nombre.
    me->ls_estructura-apellido = iv_Apellido.
    me->ls_estructura-telefono = iv_telefono.
    me->experiencia = iv_experiencia.
    me->certificaciones = iv_certificaciones.
    me->ls_estructura-currency_code = 'EUR'.
  ENDMETHOD.

  METHOD ex_id_empleado.
  "Si no hay valores en la BD, se añade el primer ID de empleado
 "de lo contrario.
    SELECT MAX( id_empleado )
    FROM ztab_eje_obj_jpf
    INTO @DATA(var_seleccion).
 "si es 0, existe al menos una fila.
    IF sy-subrc = 0.
      me->ls_estructura-id_empleado = var_seleccion + 1.
    ELSE.
      me->ls_estructura-id_empleado = 0001.
    ENDIF.
  ENDMETHOD.

  METHOD calcular_sueldo.
  "se obtiene el sueldo a partir de otros dos datos y se guarda en la estructura
    me->ls_estructura-sueldo = ( me->certificaciones * 50 + me->experiencia * 100 ) + 1000.
  ENDMETHOD.

  METHOD alta_empleado.
  "este es el método "principal" que se invoca desde MAIN.
  "primero llama a los otros dos métodos.
     me->calcular_sueldo(  ).
     me->ex_id_empleado(  ).
 " como en la BD no hay campo con el mismo campo clave de la estructura, añade el registro.
    MODIFY ztab_eje_obj_jpf FROM @ls_estructura.
 "si se ha podido realizar la operación, se hace commit y deja un mensaje en la variable de return.
    IF sy-subrc = 0.
      COMMIT WORK.
      rv_mensaje = |Subida correcta|.
    ELSE.
      rv_mensaje = |Error en la Subida |. " si no se ha realizado.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
