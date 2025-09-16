@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'información de sesión'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_INF_SESION_JPF as select from /dmo/customer
{
key customer_id as CustomerID,
    $session.client  as ClientField,
    $session.system_date as SystiemDate,
    $session.system_language as SystemLanguage,
    $session.user     as UserField,
    $session.user_date  as UserDate,
    $session.user_timezone as UserTz   
}
