CLASS zcl_170422996_work_with_intbl1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422996_work_with_intbl1 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*---------------------------------------------------------------------
* Connection Types
*---------------------------------------------------------------------

    TYPES: BEGIN OF st_connection,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES: tt_connections TYPE SORTED TABLE OF st_connection
             WITH NON-UNIQUE KEY carrier_id connection_id.

    DATA: connections TYPE tt_connections,
          connection  LIKE LINE OF connections.

*---------------------------------------------------------------------
* Carrier Types
*---------------------------------------------------------------------

    TYPES: BEGIN OF st_carrier,
             carrier_id    TYPE /dmo/carrier_id,
             currency_code TYPE /dmo/currency_code,
           END OF st_carrier.

    DATA carriers TYPE STANDARD TABLE OF st_carrier
         WITH NON-UNIQUE KEY carrier_id.
    DATA carrier  LIKE LINE OF carriers.

*---------------------------------------------------------------------
* Sample Data
*---------------------------------------------------------------------

    connections = VALUE #(
      ( carrier_id      = 'OL'
        connection_id   = '04081'
        airport_from_id = 'FRA'
        airport_to_id   = 'NRT'
        carrier_name    = 'Japan Airlines' )
      ( carrier_id      = 'AA'
        connection_id   = '0017'
        airport_from_id = 'MIA'
        airport_to_id   = 'HAV'
        carrier_name    = 'American Airlines' )
      ( carrier_id      = '5Q'
        connection_id   = '0001'
        airport_from_id = 'SFO'
        airport_to_id   = 'SIN'
        carrier_name    = 'Singapore Airlines' )
    ).

    carriers = VALUE #(
      ( carrier_id    = 'SQ'
        currency_code = 'USD' )
      ( carrier_id    = 'JL'
        currency_code = 'JPY' )
      ( carrier_id    = 'VY'
        currency_code = 'EUR' )
    ).

*---------------------------------------------------------------------
* Example 1: Table Expression with Key Access
*---------------------------------------------------------------------

    " Access by key fields
    connection = connections[ carrier_id = 'SQ' connection_id = '0001' ].

    " Access by non-key fields
    connection = connections[ airport_from_id = 'SFO' airport_to_id = 'SIN' ].

*---------------------------------------------------------------------
* Example 2: LOOP with key access
*---------------------------------------------------------------------

    LOOP AT connections INTO connection
      WHERE airport_from_id <> 'MIA'.
      out->write( |This is row number: { sy-tabix }| ).
    ENDLOOP.

*---------------------------------------------------------------------
* Example 3: MODIFY TABLE (key access)
*---------------------------------------------------------------------

    carrier = carriers[ 1 ]. "örnek work area initialization
    carrier-carrier_id       = 'IL'.
    carrier-currency_code    = 'JPY'.
    MODIFY TABLE carriers FROM carrier.

*---------------------------------------------------------------------
* Example 4: MODIFY (index access)
*---------------------------------------------------------------------

    carrier-carrier_id       = 'LH'.
    carrier-currency_code    = 'EUR'.
    MODIFY carriers FROM carrier INDEX 1.

*---------------------------------------------------------------------
* Example 5: MODIFY in a LOOP
*---------------------------------------------------------------------

    LOOP AT carriers INTO carrier
      WHERE currency_code IS INITIAL.
      carrier-currency_code = 'USD'.
      MODIFY carriers FROM carrier.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
