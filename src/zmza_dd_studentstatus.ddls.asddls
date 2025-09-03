@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status F4'
define view entity ZMZA_DD_STUDENTSTATUS
  as select from    DDCDS_CUSTOMER_DOMAIN_VALUE(
                      p_domain_name : 'ZMZA_STUDENTSTATUS') as Values
    left outer join DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                      p_domain_name : 'ZMZA_STUDENTSTATUS') as Texts
      on  Texts.domain_name    = Values.domain_name
      and Texts.value_position = Values.value_position
      and Texts.language       = $session.system_language
{
  key Values.value_low as Value,
      Texts.text       as Description
}
