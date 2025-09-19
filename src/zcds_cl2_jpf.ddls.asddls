@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_CL2_JPF

 as select from /dmo/booking
association [1..1] to   ZCDS_FILTRO2_JPF    as _Travel on _Travel.TravelId  = $projection.TravelId
{
    key travel_id as TravelId,
    key booking_id as BookinId,
    
   
    
    _Travel.AgencyId,
     _Travel._Agency.name as AgencyName,
     _Travel._Customer.customer_id as CustomerID,
     concat_with_space(_Travel._Customer.first_name, _Travel._Customer.last_name, 2) as CustomerName
     
     
}
where carrier_id = 'AA';
