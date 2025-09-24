@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'paso por parametro'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_repaso7_jpf
  with parameters
    pFromCurrency : abap.cuky,
    pToCurrency   : abap.cuky

  as select from /dmo/travel

{
  key travel_id                           as TravelId,
    @Semantics.amount.currencyCode: 'OriginalCurrency'
  total_price as PrecioOriginal,
      currency_code                       as OriginalCurrency,
      @Semantics.amount.currencyCode: 'ConvertedCurrency'


      currency_conversion( amount => total_price,
       source_currency => $parameters.pFromCurrency,
        target_currency => $parameters.pToCurrency,
        exchange_rate_date => begin_date,
        client => $session.client,
        error_handling => 'SET_TO_NULL') as ConvertedPrice,

      $parameters.pToCurrency             as ConvertedCurrency


}
