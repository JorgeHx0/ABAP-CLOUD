@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'filtro 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_FILTRO2_JPF
as select from /dmo/travel as Travel
 
association [1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerId
association [1..1] to /dmo/agency as _Agency on _Agency.agency_id = $projection.AgencyId
 
 
{
  key Travel.travel_id as TravelId,
  Travel.customer_id   as CustomerId,
  Travel.agency_id     as AgencyId,
  _Customer,
  _Agency
    
}
