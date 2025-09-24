//1. Joins
//Crear la vista CDS “ZCDS_JOIN_USER” que combine las tablas
///dmo/booking y /dmo/flight utilizando un inner join. Declarando los
//siguientes campos en la vista CDS:
//● BOOKING_ID: Como campo clave de la tabla /dmo/booking.
//● FLIGHT_DATE: de la tabla /dmo/flight.
//● PRICE: de la tabla /dmo/flight.
//● CURRENCY_CODE: de la tabla /dmo/flight.


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
  as select from /dmo/booking as booking
 
  
  inner join /dmo/flight as Flight on booking.connection_id = Flight.connection_id
  
  {
      key booking.booking_id as Booking_ID,
     Flight.flight_date as Flight_date,
     @Semantics.amount.currencyCode: 'CurrencyCode'
        Flight.price as Price,
        Flight.currency_code as CurrencyCode
  
  


}
