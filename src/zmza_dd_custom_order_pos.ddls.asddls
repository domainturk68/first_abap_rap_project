@EndUserText.label: 'Sipariş position custom entity'
@ObjectModel: {
    query: { implementedBy: 'ABAP:ZCL_ZMZA_CUSTOM_ORDER' }
}
@Metadata.allowExtensions: true
define custom entity zmza_dd_custom_order_pos
{
  key VBELN         : VBELN_VA;
  key POSNR         : POSNR_VA;
      MATNR         : MATNR;        
    _Order          : association to parent zmza_dd_custom_order 
                      on $projection.VBELN = _Order.VBELN;
}
