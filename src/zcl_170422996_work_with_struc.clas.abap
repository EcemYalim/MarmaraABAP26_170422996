CLASS zcl_170422996_work_with_struc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422996_work_with_struc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES: BEGIN OF st_connection_short,
             departure_airport   TYPE /dmo/airport_from_id,
             destination_airport TYPE /dmo/airport_to_id,
           END OF st_connection_short.

    TYPES: BEGIN OF st_connection_multi,
             airport_from_id     TYPE /dmo/airport_from_id,
             airport_to_id       TYPE /dmo/airport_to_id,
             carrier_name        TYPE /dmo/carrier_name,
             departure_airport   TYPE /dmo/airport_from_id,
             destination_airport TYPE /dmo/airport_to_id,
           END OF st_connection_multi.

    DATA: connection        TYPE st_connection,
          connection_short  TYPE st_connection_short,
          connection_multi  TYPE st_connection_multi,
          connection_full   TYPE /dmo/i_connection.

**********************************************************************
* Example 1: Field Mapping (Alias kullanarak)
**********************************************************************

    SELECT SINGLE
      FROM /dmo/i_connection
      FIELDS
        departureairport   AS airport_from_id,
        destinationairport AS airport_to_id,
        airlineid          AS carrier_name
      WHERE airlineid = 'LH'
        AND connectionid = '0400'
      INTO @connection.

**********************************************************************
* Example 2: FIELDS *
**********************************************************************

    SELECT SINGLE
      FROM /dmo/i_connection
      FIELDS *
      WHERE airlineid = 'LH'
        AND connectionid = '0400'
      INTO @connection_full.

**********************************************************************
* Example 3: INTO CORRESPONDING FIELDS
**********************************************************************

    SELECT SINGLE
  FROM /dmo/i_connection
  FIELDS
    departureairport   AS departure_airport,
    destinationairport AS destination_airport
  WHERE airlineid   = 'LH'
    AND connectionid = '0400'
  INTO CORRESPONDING FIELDS OF @connection_short.
**********************************************************************
* Example 4: Alias Names + CORRESPONDING
**********************************************************************

    CLEAR connection.

    SELECT SINGLE
      FROM /dmo/i_connection
      FIELDS
        departureairport   AS airport_from_id,
        destinationairport AS airport_to_id,
        airlineid          AS carrier_name
      WHERE airlineid = 'LH'
        AND connectionid = '0400'
      INTO CORRESPONDING FIELDS OF @connection.


**********************************************************************
* Example 5: Inline DATA + Alias
**********************************************************************

SELECT SINGLE
  FROM /dmo/i_connection
  FIELDS
    departureairport   AS departure_airport,
    destinationairport AS arrival_airport,
    airlineid          AS carrier_name
  WHERE airlineid = 'LH'
    AND connectionid = '0400'
  INTO @DATA(connection_inline).


**********************************************************************
* Example 6: JOIN ile Airport Name Çekme
**********************************************************************

SELECT SINGLE
  FROM /dmo/connection AS c
  LEFT OUTER JOIN /dmo/airport AS f
    ON c~airport_from_id = f~airport_id
  LEFT OUTER JOIN /dmo/airport AS t
    ON c~airport_to_id = t~airport_id
  FIELDS
    c~airport_from_id,
    c~airport_to_id,
    f~name AS airport_from_name,
    t~name AS airport_to_name
  WHERE c~carrier_id    = 'LH'
    AND c~connection_id = '0400'
  INTO @DATA(connection_joined).


**********************************************************************
* Example 7
**********************************************************************
connection_multi-departure_airport   = connection_short-departure_airport.
connection_multi-destination_airport = connection_short-destination_airport.




































  ENDMETHOD.

ENDCLASS.
