CLASS zcl_repaso__2_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_repaso__2_jpf IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lv_page_number      TYPE i VALUE 2,
          lv_records_per_page TYPE i VALUE 5.

    DATA gv_offset TYPE  int8.
    gv_offset = ( lv_page_number - 1 ) * lv_records_per_page.

    SELECT FROM zcds_repaso12_jpf
    FIELDS CustomerID AS Customer_ID, PhoneNumber AS Phone_Number, EmailAdress AS Email_Adress
    order by CustomerID
    INTO TABLE @DATA(lt_tabla)
    OFFSET @gv_offset
           UP TO @lv_records_per_page ROWS.

    IF sy-subrc = 0.
      out->write( lt_tabla ).
      data(lv_contar_paginas) = lines( lt_tabla ).
      out->write( |se han mostrado { lv_contar_paginas } líneas| ).
    ELSE.
      out->write( 'sin datos' ).

    ENDIF.


  ENDMETHOD.

ENDCLASS.
