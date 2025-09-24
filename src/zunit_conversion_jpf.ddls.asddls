//7. Conversión de Unidad
//Crear la vista CDS “ZUNIT_CONVERSION_USER”. Usar la función
//UNIT_CONVERSION para convertir las cantidades del componente
//FIELD_WITH_QUANTITY con la unidad A a la unidad W. utilizando la
//tabla /dmo/fsa_root_a. Declarando los siguientes campos en la vista
//CDS:
//● ID. Como campo clave.
//● STRING_PROPERTY.
//● UOM.
//● FIELD_WITH_QUANTITY.
//Además, manejar los errores con SET_TO_NULL


@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'eje cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZUNIT_CONVERSION_jpf as select from
/dmo/fsa_root_a
{
key id as Id,
string_property as StringProperty,
uom,
@Semantics.quantity.unitOfMeasure: 'UOM'
unit_conversion( quantity => field_with_quantity,
source_unit => abap.unit'A',
target_unit => abap.unit'W',
error_handling => 'SET_TO_NULL' ) as
FIELD_WITH_QUANTITY_KG_USER
}
