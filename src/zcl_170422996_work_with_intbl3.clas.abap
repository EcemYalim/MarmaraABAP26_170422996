CLASS zcl_170422996_work_with_intbl3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422996_work_with_intbl3 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*---------------------------------------------------------------------
* Field definitions
*---------------------------------------------------------------------

    TYPES: BEGIN OF ty_employee,
             pernr         TYPE i,
             ad            TYPE string,
             soyad         TYPE string,
             yas           TYPE i,
             kayit_tarihi  TYPE d,
           END OF ty_employee.

*---------------------------------------------------------------------
* Table type definitions
*---------------------------------------------------------------------

    TYPES: tt_standard TYPE STANDARD TABLE OF ty_employee
             WITH NON-UNIQUE KEY pernr.

    TYPES: tt_sorted TYPE SORTED TABLE OF ty_employee
             WITH UNIQUE KEY pernr.

    TYPES: tt_hashed TYPE HASHED TABLE OF ty_employee
             WITH UNIQUE KEY pernr.

*---------------------------------------------------------------------
* Data definitions
*---------------------------------------------------------------------

    DATA: lt_standard TYPE tt_standard,
          lt_sorted   TYPE tt_sorted,
          lt_hashed   TYPE tt_hashed,
          ls_employee TYPE ty_employee.

*---------------------------------------------------------------------
* Record Insert
*---------------------------------------------------------------------

    ls_employee-pernr = 1001.
    ls_employee-ad = 'Ali'.
    ls_employee-soyad = 'Yilmaz'.
    ls_employee-yas = 28.
    ls_employee-kayit_tarihi = '20230115'.
    APPEND ls_employee TO lt_standard.
    INSERT ls_employee INTO TABLE lt_sorted.
    INSERT ls_employee INTO TABLE lt_hashed.
    CLEAR ls_employee.

    ls_employee-pernr = 1002.
    ls_employee-ad = 'veli'.
    ls_employee-soyad = 'Yilmaz'.
    ls_employee-yas = 29.
    ls_employee-kayit_tarihi = '20230115'.
    APPEND ls_employee TO lt_standard.
    INSERT ls_employee INTO TABLE lt_sorted.
    INSERT ls_employee INTO TABLE lt_hashed.
    CLEAR ls_employee.

    ls_employee-pernr = 1003.
    ls_employee-ad = 'aliye'.
    ls_employee-soyad = 'Yilmaz'.
    ls_employee-yas = 30.
    ls_employee-kayit_tarihi = '20230115'.
    APPEND ls_employee TO lt_standard.
    INSERT ls_employee INTO TABLE lt_sorted.
    INSERT ls_employee INTO TABLE lt_hashed.
    CLEAR ls_employee.

    ls_employee-pernr = 1004.
    ls_employee-ad = 'veliye'.
    ls_employee-soyad = 'Yilmaz'.
    ls_employee-yas = 31.
    ls_employee-kayit_tarihi = '20230115'.
    APPEND ls_employee TO lt_standard.
    INSERT ls_employee INTO TABLE lt_sorted.
    INSERT ls_employee INTO TABLE lt_hashed.
    CLEAR ls_employee.

    ls_employee-pernr = 1005.
    ls_employee-ad = 'fehmi'.
    ls_employee-soyad = 'Yilmaz'.
    ls_employee-yas = 32.
    ls_employee-kayit_tarihi = '20230115'.
    APPEND ls_employee TO lt_standard.
    INSERT ls_employee INTO TABLE lt_sorted.
    INSERT ls_employee INTO TABLE lt_hashed.
    CLEAR ls_employee.

*---------------------------------------------------------------------
* 1-) Linear search
*---------------------------------------------------------------------

    READ TABLE lt_standard INTO ls_employee WITH KEY pernr = 1003.

    IF sy-subrc = 0.
      out->write( |Employee found: { ls_employee-pernr } { ls_employee-ad } { ls_employee-soyad }| ).
    ENDIF.

    CLEAR ls_employee.

*---------------------------------------------------------------------
* 2-) Binary search
*---------------------------------------------------------------------

    SORT lt_standard BY ad.

    READ TABLE lt_standard INTO ls_employee
      WITH KEY ad = 'Zeynep'
      BINARY SEARCH.

    IF sy-subrc = 0.
      out->write( |Employee found: { ls_employee-pernr } { ls_employee-ad } { ls_employee-soyad }| ).
    ENDIF.

    CLEAR ls_employee.

*---------------------------------------------------------------------
* 3-) Sorted table search
*---------------------------------------------------------------------

    READ TABLE lt_sorted INTO ls_employee
      WITH TABLE KEY pernr = 1002.

    IF sy-subrc = 0.
      out->write( |Employee found: { ls_employee-pernr } { ls_employee-ad } { ls_employee-soyad }| ).
    ENDIF.

*---------------------------------------------------------------------
* 4-) Hashed table search
*---------------------------------------------------------------------

    READ TABLE lt_hashed INTO ls_employee
      WITH TABLE KEY pernr = 1004.

    IF sy-subrc = 0.
      out->write( |Employee found: { ls_employee-pernr } { ls_employee-ad } { ls_employee-soyad }| ).
    ENDIF.

    CLEAR ls_employee.

  ENDMETHOD.

ENDCLASS.
