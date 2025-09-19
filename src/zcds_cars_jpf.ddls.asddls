@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cars'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_cars_jpf as select from ztab_rentcar_jpf
{
   key matricula as Matricula,
   marca as Marca,
   modelo as Modelo,
   color as Color,
   motor as Motor,
   potencia as Potencia,
   und_potencia as UndPotencia,
   combustible as Combustible,
   consumo as Consumo,
   puertas as Puertas,
   @Semantics.amount.currencyCode:'moneda'
   precio as Precio,
   moneda as Moneda,
   alquilado as Alquilado,
   alq_desde as AlqDesde,
   alq_hasta as AlqHasta
}
