@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds de ejemplo'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_cds_jpf with parameters
pCountryCode : land1

as select from /dmo/agency

{
  agency_id as AgencyId,
  name as Name,
  street as Street,
  postal_code as PostalCode,
  city as City,
  country_code as CountryCode,
  phone_number as PhoneNumber,
  email_address as EmailAddress,
  web_address as WebAddreess,
  attachment as Attachment,
  mime_type as MineType,
  filename as Filename
      
}

where country_code = $parameters.pCountryCode
