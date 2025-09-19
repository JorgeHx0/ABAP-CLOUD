@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONVERSIÓN DE MONEDA'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSALES_CONVERTED_JPF
  as select from /dmo/booking

  //ctrl espacio y después shift enter
{
    currency_code,
    @Semantics.amount.currencyCode: 'currency_code'
  currency_conversion(
                        amount => flight_price,
                        source_currency => currency_code ,
                        target_currency => abap.cuky'USD',
                        exchange_rate_date => $session.system_date  ,
                        error_handling =>  'SET_TO_NULL' ) as FLIGHT_PRICE_USD 
}
