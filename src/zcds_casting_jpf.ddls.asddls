@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS casting'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #B,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_CASTING_JPF 
as select from /dmo/flight
{
    key carrier_id as AirlineID,                 
    key connection_id as ConnectionID,
    key flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'Currency'
    @EndUserText.label: 'Price'
    price as Price,
    currency_code as Currency,
    
    'UDS'   as CurrencyDocument,
    '20300101' as DateString,  
    
    cast( '20300101' as abap.dats ) as DataDate, 
    1.2 as FloatingPointElement,
    fltp_to_dec(1.2 as abap.dec(4, 2)) as DecimalElement, 
    cast( 'E' as abap.lang ) as LanguageElement
}
