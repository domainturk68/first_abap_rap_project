CLASS zcl_zmza_custom_order DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zmza_custom_order IMPLEMENTATION.

  METHOD if_rap_query_provider~select.

    IF io_request->is_data_requested( ).
      "Paging concept
*To read the Paging and offset data use below functions.
*IO_REQUEST->GET_PAGING( )->GET_PAGE_SIZE( )
*IO_REQUEST->GET_PAGING( )->GET_OFFSET( )
      DATA(lv_top) = io_request->get_paging( )->get_page_size( ).
      IF lv_top < 0.
        lv_top = 1.
      ENDIF.
      DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
*To read the sort element information use
*IO_REQUEST-> GET_SORT)ELEMTNS( )
      DATA(lv_sort) = io_request->get_sort_elements( ).
*To determine the entity name,
*use IO_REQUEST->GET_ENTITY_ID( ). This allows a single handler
*class to serve multiple custom entities by identifying which entity’s
*data fetch logic to execute.
      DATA(lv_entity_name) = io_request->get_entity_id( ).
      IF lv_entity_name = 'ZMZA_DD_CUSTOM_ORDER'.
*When the user provides filter conditions on the selection screen,
*retrieve them in the handler class using
*IO_REQUEST->GET_FILTER( )->GET_AS_SQL_STRING().
        DATA(lv_conditions) = io_request->get_filter( )->get_as_sql_string( ).

        SELECT vbeln,
               auart,
               ernam
        FROM vbak
        WHERE (lv_conditions)
        ORDER BY vbeln
        INTO TABLE @DATA(lt_order)
        OFFSET @lv_offset
        UP TO @lv_top ROWS.
*If the entity is Order, then execute the travel logic. When filter
*conditions are provided, include them in the WHERE clause of
*the SELECT query; otherwise, skip the WHERE clause.
*Additionally, apply the offset and paging parameters retrieved
*from the earlier code.
        DATA(lv_total) = lv_offset + lv_top.
*To set the output data use.
*IO_RESPONSE->SET_DATA( )
*To set the the total number of records use.
*IO_RESPONSE->SET_TOTAL_NUMBER_OF_RECORDS( )
        io_response->set_total_number_of_records( lv_total ).
        io_response->set_data( lt_order ).
      ELSEIF lv_entity_name = 'ZMZA_DD_CUSTOM_ORDER_POS'.
        lv_conditions = io_request->get_filter( )->get_as_sql_string( ).
        SELECT vbeln,
               posnr,
               matnr
        FROM vbap
        WHERE (lv_conditions)
        ORDER BY vbeln, posnr
        INTO TABLE @DATA(lt_order_pos)
        OFFSET @lv_offset
        UP TO @lv_top ROWS.

        lv_total = lv_offset + lv_top.
        io_response->set_total_number_of_records( lv_total ).
        io_response->set_data( lt_order_pos ).
*If the entity is Positions, execute the position logic. Since the
*filter conditions include the header entity key, incorporate them
*into the WHERE clause of the SELECT query. Apply the offset
*and paging parameters from the earlier code as well.
*The RAP framework automatically handles the ExpandEntitySet
*call and its data mapping. If we set the output data to
*IO_RESPONSE->SET_DATA( )
*To set the the total number of records use.
*IO_RESPONSE->SET_TOTAL_NUMBER_OF_RECORDS( )
      ENDIF.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
