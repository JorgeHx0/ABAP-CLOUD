//4. Asociaciones Filtradas - Path Expression - cardinalidad
//Crear la vista CDS “ZCDS_PATH_EXPRESS_USER” que relacione la
//tabla /dmo/booking con la vista cds /dmo/flight la asociación debe
//ser cero a muchos. Declarando los siguientes campos en la vista CDS:
//● BOOKING_ID: Como campo clave de la tabla /dmo/booking.
//● TRAVEL_ID: Como campo clave de la tabla /dmo/booking.
//● SEATS_OCCUPIED: de la tabla /dmo/flight. Especificar la
//cardinalidad 1 y además de agregar el path expressions para
//poder filtrar por el componente connection id = '0001'.


@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejer path expressions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_PATH_EXPRESS_JPF as select from /dmo/booking as Booking
//inner join /dmo/flight as Flight on Flight.connection_id = Booking.connection_id
//{
//  key Booking.booking_id as Booking_Id, 
// key Booking.travel_id as Travel_Id,
// Flight.seats_occupied as SeatsOccupied 
//}

//association [0..*] to /dmo/flight as _Flight on Booking.connection_id = _Flight.connection_id
// 
//{
//key Booking.booking_id as BookingId,
//key Booking.travel_id as TravelId,
//_Flight[ 1: connection_id = '0001' ].seats_occupied as SeatsOccupied,
//connection_id as Connection_Id
//}


association [0..*] to /dmo/flight as _Flight on Booking.connection_id
= _Flight.connection_id
{
key Booking.booking_id as BookingId,
key Booking.travel_id as TravelId,
_Flight[ 1: connection_id = '0001'].seats_occupied as
SeatsOccupied
}
