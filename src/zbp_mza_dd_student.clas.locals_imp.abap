CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Student RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.

    METHODS SetAdmitted FOR MODIFY
      IMPORTING keys FOR ACTION Student~SetAdmitted RESULT result.
    METHODS validate_mandatory_fields FOR VALIDATE ON SAVE
      IMPORTING keys FOR Student~validate_mandatory_fields.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD SetAdmitted.
  ENDMETHOD.

  METHOD validate_mandatory_fields.

    " Read the student data
    READ ENTITIES OF zmza_dd_student IN LOCAL MODE
    ENTITY student
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_studentdata)
    REPORTED DATA(lt_reported)
    FAILED DATA(lt_failed).

    LOOP AT lt_studentdata INTO DATA(ls_studentdata).
      "Validation
      IF ls_studentdata-Course IS INITIAL.
        "Step - 1 fill failed parameter in case of error
        failed-student = VALUE #(
                ( %tky = ls_studentdata-%tky  )
            ).
        "Step - 2 specify a message if any of the information is missing
        reported-student = VALUE #(
                                    ( %tky = ls_studentdata-%tky
                                      %msg = new_message(   id = 'SY'
                                                            number = '002'
                                                            v1 = 'Course is mandatory'
                                                            severity = if_abap_behv_message=>severity-error
                                                        )
                                     %element-course = if_abap_behv=>mk-on
                                    )
                                  ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
