@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help Studentstatus'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'Domvalue'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMZA_DD_DD07T_CUST_TYPE
  as select from dd07t as CustType
{
  key domname    as Domname,
  key ddlanguage as Ddlanguage,
  key as4local   as State,
  key valpos     as Pposition,
  key as4vers    as Version,
      ddtext     as Description,
      domvalue_l as Domvalue
}
where
      CustType.domname  = 'ZMZA_STUDENTSTATUS'
  and CustType.as4local = 'A'
  and ddlanguage        = $session.system_language
