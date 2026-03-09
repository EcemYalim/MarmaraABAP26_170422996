CLASS zcl_170422996_global_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_170422996_global_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    "1) İlk connection
    connection = NEW #( ).
    connection->set_attributes(
      i_carrier_id    = 'IH'
      i_connection_id = '0400'
    ).
    APPEND connection TO connections.

    "2) İkinci connection
    connection = NEW #( ).
    connection->set_attributes(
      i_carrier_id    = 'AA'
      i_connection_id = '0017'
    ).
    APPEND connection TO connections.

    "3) Tablodaki tüm connection nesnelerini yazdır
    LOOP AT connections INTO DATA(conn).
      conn->get_attributes(
        IMPORTING
          e_carrier_id    = carrier_id
          e_connection_id = connection_id
      ).
      out->write( |Flight connection { carrier_id } { connection_id }| ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
