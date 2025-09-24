//ver zcds_cust_book_user

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejer asociación parent-child'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_CUSTOMER_ROOT_JPF as select from /dmo/booking
{
   key travel_id as TravelId,
   key booking_id as BookingId,
   customer_id as CustomerId,
   flight_date as Flight_date
   
   
   
}
