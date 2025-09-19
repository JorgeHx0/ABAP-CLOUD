@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_CL_JPF

 as select from /dmo/booking
association [1..1] to   ZCDS_FILTRO2_JPF    as _Travel on _Travel.TravelId  = $projection.TravelId
{
    key travel_id as TravelId,
    key booking_id as BookinId,
    booking_date   as BookingDate,
    customer_id    as CustomerId,
    carrier_id     as CarrierId,
    connection_id  as ConnectionId,
    flight_date    as FlightDate,
    _Travel
}
