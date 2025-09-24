//5. Asociación - Parent Child
//Crear la vista CDS ZCDS_CUST_BOOK_USER consultando la tabla
///dmo/booking que represente la asociación parent-child entre las
//entidades ZCDS_CUSTOMER_ROOT_USER y
//ZCDS_CUST_BOOK_USER. Declarando los siguientes componentes
//de la vista CDS:
//● customer_id: Campo clave de la tabla /dmo/customer.
//● travel_id: Campo clave de la tabla /dmo/booking.
//● booking_id: Campo clave de la tabla /dmo/booking.
//● _CUSTOMER: Asociación a la entidad padre
//ZCDS_CUSTOMER_ROOT_USER.


@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejercio asociacion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_cust_book_user
// as select from ZCDS_CUSTOMER_ROOT_JPF as Parent
//association [1..*] to /ZCDS_CUST_BOOK_JPF as _Customer on _Customer.customer_id = $projection.Customer_Id
//{
//   key Parent.TravelId,
//   key Parent.BookingId,
//   Parent.CustomerId as Customer_id
   
//}
as select from ZCDS_CUSTOMER_ROOT_JPF as Customer
association [0..*] to ZCDS_CUST_BOOK_JPF as Booking on
Customer.CustomerId = Booking.CustomerId
{
key Customer.CustomerId as CustomerId,
Booking.FirstName as FirstName,
Booking.LastName as LastName,
Customer[inner].Flight_date as BookingDate
}
