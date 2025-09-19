CLASS zcl_cds_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cds_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.
select from zcds_cl_jpf as Booking
FIELDS
Booking~TravelId,
Booking~BookinId,
\_travel-AgencyId,
\_travel\_Agency-name as AgencyName,
\_Travel\_Customer-customer_id as CustomerID,
concat_with_space(  \_Travel\_Customer-first_name,   \_Travel\_Customer-last_name, 1 ) as CustomerName
where Booking~CarrierId = 'AA'
into table @Data(lt_results)
up to 5 rows.

if sy-subrc = 0.
out->write( lt_results ).
endif.

ENDMETHOD.


ENDCLASS.
