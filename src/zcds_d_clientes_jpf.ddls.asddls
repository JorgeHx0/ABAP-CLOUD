@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'd clientes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_d_clientes_jpf as select from ztab_cstomer_jpf
{
  key doc_id as DocId,
  key matricula as Matricula,
  fecha_inicio as FechaInicio,
  fecha_fin as FechaFin,
  nombres as Nombres,
  apellidos as Apellidos,
  email as Email,
  cntr_type as CntrType   
}
