CLASS zcl_muchos_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_muchos_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.


get time stamp field data(lv_timestamp_begin).

    DELETE FROM ztab_invoice_jpf.

    DO 100000 TIMES.

      MODIFY ztab_invoice_jpf FROM TABLE @( VALUE #(

                                    ( invoice_id = sy-index
                                      comp = '1010'
                                      customer = 'coca-cola'
                                      status = 1
                                      created_by = cl_abap_context_info=>get_user_technical_name(  )
                                      amount = '1000'
                                      currency_key = 'USD' )

                                    ( invoice_id = sy-index
                                      comp = '1020'
                                      customer = 'Pepsi'
                                      status = 1
                                      created_by = cl_abap_context_info=>get_user_technical_name(  )
                                      amount = '2000'
                                      currency_key = 'USD' )


                                    ( invoice_id = sy-index
                                      comp = '1030'
                                      customer = 'patatas'
                                      status = 1
                                      created_by = cl_abap_context_info=>get_user_technical_name(  )
                                      amount = '500'
                                      currency_key = 'USD' )

                                    ( invoice_id = sy-index
                                      comp = '1040'
                                      customer = 'Piña'
                                      status = 1
                                      created_by = cl_abap_context_info=>get_user_technical_name(  )
                                      amount = '1000'
                                      currency_key = 'USD' )

                                    ( invoice_id = sy-index
                                      comp = '1050'
                                      customer = 'Manzana'
                                      status = 1
                                      created_by = cl_abap_context_info=>get_user_technical_name(  )
                                      amount = '1000'
                                      currency_key = 'EUR' )


       ) ).



    ENDDO.

    get time stamp field data(lv_timestamp_end).

    data(lv_dif_sec) = cl_abap_tstmp=>subtract(  exporting tstmp1 = lv_timestamp_end
                                                            tstmp2 = lv_timestamp_begin ).







ENDMETHOD.
ENDCLASS.
