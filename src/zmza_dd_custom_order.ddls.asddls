@EndUserText.label: 'Sipariş header custom entity'
@ObjectModel: {
    query: { implementedBy: 'ABAP:ZCL_ZMZA_CUSTOM_ORDER' }
}
@Metadata.allowExtensions: true
define root custom entity zmza_dd_custom_order
{
  key VBELN     : vbeln_va;
      AUART     : auart;
      ERNAM     : ernam;
      _Position : composition [1..*] of zmza_dd_custom_order_pos;

}
