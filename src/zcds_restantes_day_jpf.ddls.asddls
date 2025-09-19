@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'dias restantes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_RESTANTES_DAY_JPF as select from ztab_rentcar_jpf
{
    key matricula as Matricula,
    marca as Marca,
    -1*dats_days_between(cast ( $session.system_date as abap.dats ), alq_hasta ) as Dias
}
