CLASS zcl_repaso_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_repaso_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

select from zcds_repaso11_jpf as Booking
FIELDS Booking~TravelId,
Booking~BookingId,
\_Travel-AgencyId,
\_Travel\_Agency-name as AgencyName,
\_Travel\_Customer-customer_id as CustomerID,
concat_with_space( \_Travel\_Customer-first_name, \_Travel\_Customer-last_name, 2 ) as NombreyApellido
where booking~CarrierId = 'AA'
into table @data(lt_resultados).

if sy-subrc = 0.
out->write( lt_resultados ).
endif.









ENDMETHOD.
ENDCLASS.
