@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'union'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_repaso5_jpf as select from /dmo/travel
{
    key travel_id as travelId,
    cast(' ' as abap.numc( 4 )) as BookingID //este campo no existe en dmo/travel
}

union select from /dmo/booking
{
    key travel_id as travelId,
    booking_id as BookingID
}

//si se repiten registros, no se repiten los registros
