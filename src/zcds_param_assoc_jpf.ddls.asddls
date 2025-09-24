//2. Asociaciones con Parámetros
//Crear la vista CDS “ZCDS_PARAM_ASSOC_USER” que relacione las
//tablas /dmo/flight y /dmo/carrier utilizar un parámetro para filtrar
//por el componente carrier_id, además la asociación debe ser de 0 a
//1. Declarando los siguientes campos en la vista CDS:
//● CARRIER_ID: Como campo clave de la tabla /dmo/flight.
//● CONNECTION_ID: Como campo clave de la tabla /dmo/flight.
//● FLIGHT_DATE: Como campo clave de la tabla /dmo/flight.
//● NAME: de la tabla /dmo/carrier.

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejercicio parametro'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_PARAM_ASSOC_JPF
with parameters pCarrierId : /dmo/carrier_id
 as select from /dmo/flight

association [0..1] to /dmo/carrier as _Carrier on _Carrier.carrier_id = $projection.CarrierId
{
   key carrier_id as CarrierId,
   key connection_id as ConnectionId,
   key flight_date as FlightDate,
   _Carrier.name as Name 
}
where carrier_id = $parameters.pCarrierId
