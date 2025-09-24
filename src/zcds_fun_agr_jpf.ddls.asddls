@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS funciones de agragación'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_FUN_AGR_JPF
as select from /dmo/travel
{
    key travel_id as TravelID,
        agency_id as AgencyID,
      
     @Semantics.amount.currencyCode: 'CurrencyCode'   
     min( total_price ) as MinTotalPrice,
     @Semantics.amount.currencyCode: 'CurrencyCode'   
     max( total_price ) as MaxTotalPrice,
     @Semantics.amount.currencyCode: 'CurrencyCode'   
     sum( total_price ) as SumTotalPrice,
     
     count( distinct total_price ) as CountDistTotalPrice,
     
//     @Semantics.amount.currencyCode: 'CurrencyCode'   
//     count( * ) as CountDistTotalPrice,
     
     currency_code as CurrencyCode
}
group by
    travel_id,
    agency_id,
    currency_code;
