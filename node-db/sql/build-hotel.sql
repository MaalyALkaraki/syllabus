-- build the cyfhotel database
--

drop table if exists invoices;
drop table if exists reservations;
drop table if exists customers;
drop table if exists rooms;
drop table if exists room_types;

\include_relative room_types.sql
\include_relative rooms.sql
\include_relative customers.sql
\include_relative reservations.sql
\include_relative fixup-dates.sql
\include_relative invoices.sql

