@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'como asociación path pero sin parameter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_inner_jpf as select from /dmo/travel as Travel
association[1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerId
association[1..1] to /dmo/agency as _Agency on _Agency.agency_id = $projection.AgencyId
{
    key Travel.travel_id,
    Travel.customer_id as CustomerId,
    concat_with_space(_Customer.first_name[inner] , _Customer.last_name[inner], 2) as CustomerName,
    Travel.agency_id as AgencyId,
    _Agency.name as AgencyName
}
