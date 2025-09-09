CLASS zcl_creador_objeto_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_creador_objeto_jpf IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

*DATA lo_contract type ref to zcl_clase_creadora_der.
*create object lo_contract.
*lo_contract = new #( ).


    DATA(lo_contract) = NEW zcl_clase_creadora_jpf( ).
    DATA lv_process TYPE string.

    IF lo_contract IS BOUND.



      lo_contract->set_client(
        EXPORTING
          iv_client   = 'Experis'
          iv_location =  space
        IMPORTING
          ev_status   =  DATA(lv_status)
        CHANGING
          cv_process  =  lv_process
      ).


      lo_contract->get_client(
      IMPORTING
        ev_client =  data(lv_client)
      ).


     lo_contract->region = 'EU'.


    ENDIF.

       out->write( |{ lv_client }-{ lv_status }-{ lv_process }-{ lo_contract->region } | ) .




ENDMETHOD.
ENDCLASS.
