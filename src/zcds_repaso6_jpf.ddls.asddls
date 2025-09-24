@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'funciones agregacion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_repaso6_jpf as select from /dmo/travel
{
 
 
      @Semantics.amount.currencyCode: 'CurrencyCode'
      min( total_price )            as MinTotalPrecio,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      max( total_price )            as MaxTotalPrecio,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      sum( total_price )            as SumTotalPrecio,
 
      count( distinct total_price ) as CountTotalPrecio,
      count( * )                    as countTotal,
      currency_code                 as CurrencyCode
 
}
group by
 
  currency_code;
