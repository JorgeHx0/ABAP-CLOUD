CLASS zcl_practica3_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_practica3_jpf IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

data ls_prediccion type ztab_predict_jpf.
data lv_puntuacion type string.



"generador1 determina si es un día bueno, regular o malo
DATA(lv_generador1) = cl_abap_random_int=>create( seed = cl_abap_random=>seed(  )
    min = 1
    max = 3 )->get_next( ).

do 5 times.

"generador2 da valores del 1 al 5, que después se transformará en puntuaciones.

DATA(lv_generador2) = cl_abap_random_int=>create( seed = cl_abap_random=>seed(  )
    min = 1
    max = 5 )->get_next( ).

"CASE anidado. primero se determina si el día es malo, normal o bueno. Después se da
"la puntuación en función del segundo número aleatorio y lo establecido para cada tipo de día.

case lv_generador1.

when 1."dia malo

case lv_generador2.
when 1.
lv_puntuacion = 'mal'.
when 2.
lv_puntuacion = 'mal'.
when 3.
lv_puntuacion = 'regular'.
when 4.
lv_puntuacion = 'regular'.
when 5.
lv_puntuacion = 'bien'.
endcase.

when 2."dia normal

case lv_generador2.
when 1.
lv_puntuacion = 'regular'.
when 2.
lv_puntuacion = 'regular'.
when 3.
lv_puntuacion = 'bien'.
when 4.
lv_puntuacion = 'bien'.
when 5.
lv_puntuacion = 'excelente'.
endcase.

when 3."dia bueno

case lv_generador2.
when 1.
lv_puntuacion = 'bien'.
when 2.
lv_puntuacion = 'bien'.
when 3.
lv_puntuacion = 'excelente'.
when 4.
lv_puntuacion = 'excelente'.
when 5.
lv_puntuacion = 'perfecto'.
endcase.

endcase.

case sy-index.
when 1.
ls_prediccion-salud  = lv_puntuacion.
when 2.
ls_prediccion-dinero = lv_puntuacion.
when 3.
ls_prediccion-amor = lv_puntuacion.
when 4.
ls_prediccion-familia = lv_puntuacion.
when 5.
ls_prediccion-amistades = lv_puntuacion.

endcase.

enddo.

"añadimos fecha

ls_prediccion-fecha =  cl_abap_context_info=>get_system_date( ).

out->write( ls_prediccion ).

"añadir signo (pendiente)



ENDMETHOD.
ENDCLASS.
