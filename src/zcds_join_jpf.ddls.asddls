@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejer join'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_join_jpf 
as select from /dmo/booking
association [1..1] to /dmo/flight as _vuelos on _vuelos.carrier_id = $projection.CarrierID
and _vuelos.connection_id = $projection.ConnectionID
and _vuelos.flight_date =  $projection.Flight_date

{
    key booking_id as Booking_ID,
    flight_date as Flight_date,
    //_vuelos.price as Price,
    currency_code as Currency_Code,
    connection_id as ConnectionID,
    carrier_id as CarrierID
    
}
