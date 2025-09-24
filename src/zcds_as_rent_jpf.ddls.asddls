@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'as rent'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
//@Ui.headerInfo
define view entity zcds_as_rent_jpf 
 as select from zcds_cars_jpf as Cars
association [1] to ZCDS_RESTANTES_DAY_JPF as _DiasRestantes on Cars.Matricula = _DiasRestantes.Matricula
association [0..*] to zcds_marcas_jpf as _Marcas on Cars.Marca = _Marcas.Marca
association [0..*] to zcds_d_clientes_jpf as _DetCustomer on Cars.Matricula = _DetCustomer.Matricula

{
    key Matricula,
    Marca,
    Modelo,
    Color,
    Motor,
    Potencia,
    UndPotencia,
    Combustible,
    Consumo,
    Puertas,
    @Semantics.amount.currencyCode: 'Moneda'
    Precio,
    Moneda,
    Alquilado,
    AlqDesde,
    AlqHasta,
    case
    when _DiasRestantes.Dias <= 0 then 0
    when _DiasRestantes.Dias between 1 and 30 then 1
    when _DiasRestantes.Dias between 31 and 100 then 2
    when _DiasRestantes.Dias > 100 then 3
    else 0
    end as DiasRestantes,
    _Marcas.Url,
    _DetCustomer
     
}
