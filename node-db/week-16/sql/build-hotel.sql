-- build the cyfhotel database
--

drop table if exists invoices cascade;
drop table if exists reservations cascade;
drop table if exists customers cascade;
drop table if exists rooms cascade;
drop table if exists room_types cascade;

\include_relative room_types.sql
\include_relative rooms.sql
\include_relative customers.sql
\include_relative reservations.sql
\include_relative fixup-dates.sql
\include_relative invoices.sql

