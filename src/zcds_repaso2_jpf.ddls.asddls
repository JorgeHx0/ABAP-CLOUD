@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'repaso 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_repaso2_jpf
 as select from /dmo/customer
{
    key customer_id as CustomerId,
    country_code as CountryCode,
    case country_code
    when 'US' then concat('Estados Unidos', 'holaa')
    when 'DE' then concat('Alemania', last_name )
    when 'ES' then concat ('España', concat_with_space( last_name , first_name, 2))
    else 'Otro país'
    end as Case1
    
}
