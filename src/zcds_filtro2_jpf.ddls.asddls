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
//la vista parte de la tabla /dmo/travel, que contiene información de cada viaje realizado
//incluyendo la identificación del viajero (customer_id) y de la agencia de viajes (agency_id)  
association [1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerId
// creamos una relación con cardinalidad uno a uno, con la tabla /dmo/customer (que llamaremos _Customer), 
// el campo customer_id de _Customer se lleva a la columna con alias CustomerId
association [1..1] to /dmo/agency as _Agency on _Agency.agency_id = $projection.AgencyId
 
 
{
  key Travel.travel_id as TravelId,
  Travel.customer_id   as CustomerId,
  Travel.agency_id     as AgencyId,
  _Customer,
  _Agency
 
}
