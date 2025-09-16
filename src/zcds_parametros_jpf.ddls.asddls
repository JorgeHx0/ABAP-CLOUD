@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS parámetros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_PARAMETROS_JPF with parameters
pFromCurrency : abap.cuky,
pToCurrency : abap.cuky

as select from /dmo/travel
{
  key travel_id as TravelID,
  @Semantics.amount.currencyCode: 'OriginalCurrency' 
  total_price as OriginalPrice,
  currency_code as OriginalCurrency,
  
  @Semantics.amount.currencyCode: 'ConvertedCurrency' 
  currency_conversion( amount => total_price,
  source_currency => $parameters.pFromCurrency,
  target_currency => $parameters.pToCurrency,
  exchange_rate_date => begin_date,
  client => $session.client,
  error_handling => 'SET_TO_NULL' ) as ConvertedPrice,
  $parameters.pToCurrency as ConvertedCurrency
}
where
currency_code = $parameters.pFromCurrency
// F8
