CLASS zcl_170422996_work_with_intbl2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422996_work_with_intbl2 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*---------------------------------------------------------------------
* Type Definitions
*---------------------------------------------------------------------

    TYPES: BEGIN OF st_airport,
             airportid TYPE /dmo/airport_id,
             name      TYPE /dmo/airport_name,
           END OF st_airport.

    TYPES tt_airports TYPE STANDARD TABLE OF st_airport
             WITH NON-UNIQUE KEY airportid.

    DATA airports TYPE tt_airports.

*---------------------------------------------------------------------
* Example 1: Structured Variables
*---------------------------------------------------------------------

    DATA airport_full TYPE /dmo/i_airport.

    SELECT SINGLE
      FROM /dmo/i_airport
      FIELDS AirportID, Name, City, CountryCode
      WHERE City = 'Zurich'
      INTO @airport_full.

*---------------------------------------------------------------------
* Example 2: Internal Tables
*---------------------------------------------------------------------

    DATA airports_full TYPE STANDARD TABLE OF /dmo/i_airport
         WITH NON-UNIQUE KEY AirportID.

    SELECT
      FROM /dmo/i_airport
      FIELDS AirportID, Name, City, CountryCode
      WHERE City = 'London'
      INTO TABLE @airports_full.

*---------------------------------------------------------------------
* Example 3: CORRESPONDING FIELDS
*---------------------------------------------------------------------

    SELECT
      FROM /dmo/i_airport
      FIELDS *
      WHERE City = 'London'
      INTO CORRESPONDING FIELDS OF TABLE @airports.

*---------------------------------------------------------------------
* Example 4: Inline Declaration
*---------------------------------------------------------------------

    SELECT
      FROM /dmo/i_airport
      FIELDS AirportID, Name AS AirportName
      WHERE City = 'London'
      INTO TABLE @DATA(airports_inline).

*---------------------------------------------------------------------
* Example 5: ORDER BY + DISTINCT
*---------------------------------------------------------------------

    SELECT
      FROM /dmo/i_airport
      FIELDS DISTINCT CountryCode
      ORDER BY CountryCode
      INTO TABLE @DATA(countryCodes).

*---------------------------------------------------------------------
* Example 6: UNION ALL
*---------------------------------------------------------------------

    SELECT
      FROM /dmo/i_carrier
      FIELDS 'Airline' AS type, AirlineID AS Id, Name
      WHERE CurrencyCode = 'GBP'

    UNION ALL

    SELECT
      FROM /dmo/i_airport
      FIELDS 'Airport' AS type, AirportID AS Id, Name
      WHERE City = 'London'
      INTO TABLE @DATA(names).

  ENDMETHOD.

ENDCLASS.
