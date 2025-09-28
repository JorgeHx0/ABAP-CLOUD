CLASS zcl_practica_fabrica_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: ls_prediccion TYPE ztab_predict_jpf,
          lv_signo      TYPE string,
          lv_fecha      TYPE d,
          lv_mes        TYPE i,
          lv_dia        TYPE i.

    METHODS constructor IMPORTING iv_mes TYPE i
                                  iv_dia TYPE i.
    METHODS fecha RETURNING VALUE(rv_error_fecha) TYPE i.
    METHODS signo.
    METHODS prediction RETURNING VALUE(rv_prediccion) TYPE ztab_predict_jpf.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_practica_fabrica_jpf IMPLEMENTATION.
  METHOD constructor.
    me->lv_dia = iv_dia.
    me->lv_mes = iv_mes.
  ENDMETHOD.

  METHOD prediction.

    me->fecha(  ).

    DATA ls_prediccion TYPE ztab_predict_jpf.
    DATA lv_puntuacion TYPE string.

    "generador1 determina si es un día bueno, regular o malo
    DATA(lv_generador1) = cl_abap_random_int=>create( seed = cl_abap_random=>seed(  )
        min = 1
        max = 3 )->get_next( ).

    DO 5 TIMES.

      "generador2 da valores del 1 al 5, que después se transformará en puntuaciones.

      DATA(lv_generador2) = cl_abap_random_int=>create( seed = cl_abap_random=>seed(  )
          min = 1
          max = 5 )->get_next( ).

      "CASE anidado. primero se determina si el día es malo, normal o bueno. Después se da
      "la puntuación en función del segundo número aleatorio y lo establecido para cada tipo de día.

      CASE lv_generador1.

        WHEN 1."dia malo

          CASE lv_generador2.
            WHEN 1.
              lv_puntuacion = 'mal'.
            WHEN 2.
              lv_puntuacion = 'mal'.
            WHEN 3.
              lv_puntuacion = 'regular'.
            WHEN 4.
              lv_puntuacion = 'regular'.
            WHEN 5.
              lv_puntuacion = 'bien'.
          ENDCASE.

        WHEN 2."dia normal

          CASE lv_generador2.
            WHEN 1.
              lv_puntuacion = 'regular'.
            WHEN 2.
              lv_puntuacion = 'regular'.
            WHEN 3.
              lv_puntuacion = 'bien'.
            WHEN 4.
              lv_puntuacion = 'bien'.
            WHEN 5.
              lv_puntuacion = 'excelente'.
          ENDCASE.

        WHEN 3."dia bueno

          CASE lv_generador2.
            WHEN 1.
              lv_puntuacion = 'bien'.
            WHEN 2.
              lv_puntuacion = 'bien'.
            WHEN 3.
              lv_puntuacion = 'excelente'.
            WHEN 4.
              lv_puntuacion = 'excelente'.
            WHEN 5.
              lv_puntuacion = 'perfecto'.
          ENDCASE.

      ENDCASE.

      CASE sy-index.
        WHEN 1.
          ls_prediccion-salud  = lv_puntuacion.
        WHEN 2.
          ls_prediccion-dinero = lv_puntuacion.
        WHEN 3.
          ls_prediccion-amor = lv_puntuacion.
        WHEN 4.
          ls_prediccion-familia = lv_puntuacion.
        WHEN 5.
          ls_prediccion-amistades = lv_puntuacion.

      ENDCASE.

    ENDDO.

    "añadimos fecha de la consulta

    ls_prediccion-fecha =  cl_abap_context_info=>get_system_date( ).


    "añadir signo

    me->signo(  ).

    ls_prediccion-signo = lv_signo.

    rv_prediccion = ls_prediccion.

  ENDMETHOD.

  METHOD fecha.
    "transformar mes a cadena
    DATA lv_mes_string TYPE string.
    lv_mes_string = CONV string( lv_mes ).

    "si el mes tiene una cifra, se añade un 0 delante
    IF lv_mes < 10.
      DATA lv_cero TYPE string VALUE '0'.
      CONCATENATE lv_cero lv_mes_string  INTO lv_mes_string .
    ENDIF.

    CONDENSE lv_mes_string. "elimina posibles caracteres en blanco

    "transformar día a cadena
    DATA lv_dia_string TYPE string.
    lv_dia_string = CONV string( lv_dia ).

    "si el dia tiene una cifra, se añade un 0 delante
    IF lv_dia < 10.
      CONCATENATE lv_cero lv_dia_string  INTO lv_dia_string .
    ENDIF.

    CONDENSE lv_dia_string.

    "concatenar año 2000 (bisiesto) con mes y día
    DATA: lv_fecha_concat_texto TYPE string,
          lv_generic_leap_year  TYPE string VALUE '2000'.

    lv_fecha_concat_texto = |{ lv_generic_leap_year }{ lv_mes_string }{ lv_dia_string }|.

    "transformar la cadena a fecha
    lv_fecha = CONV d( lv_fecha_concat_texto ).

    "comprobación de que la fecha es correcta

    CASE lv_mes.

      WHEN 1 OR 3 OR 5 OR 7 OR 8 OR 10 OR 12.
        IF lv_dia > 31 OR lv_dia < 1.
          rv_error_fecha = '1'.
        ENDIF.

      WHEN 4 OR 6 OR 9 OR 11.
        IF lv_dia > 30 OR lv_dia < 1.
          rv_error_fecha = '1'.
        ENDIF.

      WHEN 2.
          IF lv_dia = 28 OR lv_dia = 29.
          rv_error_fecha = '0'.
          else.
          rv_error_fecha = '1'.
        ENDIF.

      WHEN OTHERS.
        rv_error_fecha = '1'.

    ENDCASE.

  ENDMETHOD.

  METHOD signo.

    IF lv_fecha > '20000320' AND lv_fecha < '20000420'.
      lv_signo = 'Aries'.

    ELSEIF lv_fecha > '20000419' AND lv_fecha < '20000521'.
      lv_signo = 'Tauro'.

    ELSEIF lv_fecha > '20000520' AND lv_fecha < '20000621'.
      lv_signo = 'Géminis'.

    ELSEIF lv_fecha > '20000620' AND lv_fecha < '20000723'.
      lv_signo = 'Cáncer'.

    ELSEIF lv_fecha > '20000722' AND lv_fecha < '20000823'.
      lv_signo = 'Leo'.

    ELSEIF lv_fecha > '20000822' AND lv_fecha < '20000923'.
      lv_signo = 'Virgo'.

    ELSE.
      lv_signo = 'error'.
    ENDIF.

    ls_prediccion-signo = lv_signo.

  ENDMETHOD.

ENDCLASS.
