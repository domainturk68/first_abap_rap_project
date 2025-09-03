REPORT zsalv_example.

DATA: lt_spfli TYPE TABLE OF spfli,
      lo_alv   TYPE REF TO cl_salv_table.

start-of-selection.

* Select data from SPFLI table
SELECT * FROM spfli INTO TABLE lt_spfli.

* Create ALV table instance
cl_salv_table=>factory(
  IMPORTING
    r_salv_table = lo_alv
  CHANGING
    t_table      = lt_spfli ).

* Display ALV
lo_alv->display( ).
