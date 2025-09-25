//Crear la entidad personalizada "ZCDS_CUSTOM_DETAIL_USER" que
//contenga los campos:
//● customer_id: como campo clave utilizando el elemento de
//datos /dmo/customer_id.
//● phone_number: utilizando el elemento de datos
///dmo/phone_number.
//● email_address: utilizando el elemento de datos
///dmo/email_address.
//Luego crear la clase ZCL_CUSTOM_DETAIL_USER implementando la
//interfaz if_rap_query_provider y vinculándola con la entidad
//personalizada. Además de agregar en la consulta de la entidad a
//través de los métodos get_offset y get_page_size las operaciones
//para empezar desde una línea o solo traer cierta cantidad de valores
//de la consulta.



@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejer repaso'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_repaso12_jpf as select from /dmo/travel as Travel
association[1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerID
{
key Travel.travel_id as TravelId,
key Travel.customer_id as CustomerID,
_Customer.phone_number as PhoneNumber,
_Customer.email_address as EmailAdress

    
}
