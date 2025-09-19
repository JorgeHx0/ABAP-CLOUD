//Crear la vista CDS “ZPARAM_CDS_USER”, utilizando la tabla
///dmo/booking. Y agregando un parámetro con el componente
//FLIGHT_DATE, para que al momento de consultar valores en dicha
//vista el usuario deba especificar una fecha. Declare los siguientes
//campos en la vista CDS:
//● TRAVEL_ID. Como campo clave.
//● BOOKING_ID. Como campo clave.
//● CUSTOMER_ID.
//● FLIGHT_DATE.



@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejercicio parámetros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPARAM_CDS_JPF 
with parameters 
pFlight_Date : abap.dats
as select from /dmo/booking
{
key travel_id as Travel_ID,
key booking_id as Booking_ID,
customer_id as Customer_ID,
flight_date as Flight_Date   
}
where flight_date = $parameters.pFlight_Date
