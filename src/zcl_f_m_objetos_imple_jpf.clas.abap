CLASS zcl_f_m_objetos_imple_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_f_m_objetos_imple_jpf IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "creamos un objeto

    DATA(lo_perro) = NEW zcl_m_y_objetos_jpf(  ).

    DATA(lo_perroDOS) = NEW zcl_m_y_objetos_jpf(  ).

    IF lo_perroDOS IS BOUND.
      lo_perroDOS->lv_nombre = 'Pancho'. "damos atributos al objeto
      lo_perroDOS->lv_raza = 'Dalmta'.
      out->write( lo_perroDOS->ladrar(  ) ).

      lo_perroDOS->lanzar_pelota(
      RECEIVING
      rv_accion = DATA(lv_action)
      ).
    ENDIF.
    out->write( lv_action ).


    IF lo_perro IS BOUND.
      lo_perro->lv_nombre = 'Dante'. "damos atributos al objeto
      lo_perro->lv_raza = 'Pastor Suizo'.
      out->write( lo_perro->ladrar(  ) ).
      out->write( lo_perro->lv_raza ) .
      lo_perro->lanzar_pelota(
      RECEIVING
      rv_accion  = lv_action
      ).


    ENDIF.
    out->write( lv_action ).

  ENDMETHOD.
ENDCLASS.
