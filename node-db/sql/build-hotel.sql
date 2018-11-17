-- build the cyfhotel database
--

drop table invoices;
drop table reservations;
drop table customers;
drop table rooms;
drop table room_types;

\include_relative room_types.sql
\include_relative rooms.sql
\include_relative customers.sql
\include_relative reservations.sql
\include_relative fixup-dates.sql
\include_relative invoices.sql

