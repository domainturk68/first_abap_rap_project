CLASS zcl_mza_virt_ele_cal DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mza_virt_ele_cal IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_cal_data TYPE STANDARD TABLE OF zmza_cw_student.

    CHECK NOT it_original_data IS INITIAL.

    MOVE-CORRESPONDING it_original_data TO lt_cal_data.

    LOOP AT lt_cal_data ASSIGNING FIELD-SYMBOL(<ls_cal_data>).

      IF <ls_cal_data>-CourseDuration IS NOT INITIAL.
        <ls_cal_data>-Duration = <ls_cal_data>-CourseDuration * 8.
      ENDIF.

    ENDLOOP.

    MOVE-CORRESPONDING lt_cal_data TO ct_calculated_data.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
