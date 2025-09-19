@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejer agragación'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDATA_AGGREGATION_JPF as select from /dmo/booking


{

    currency_code,
    @Semantics.amount.currencyCode: 'currency_code'
   
     sum(flight_price) as Suma_precios
}
group by

currency_code;
