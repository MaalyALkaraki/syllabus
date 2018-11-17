-- PL/pgSQL function to fix dates in the hotel database to make them current with the course run.

drop function fixup_dates();

create function fixup_dates() returns integer as
$$
declare
  date_adj integer;
begin
  select current_date - max(booking_date) + 30
    into date_adj
    from reservations;

  update reservations set
    booking_date  = least(current_date, booking_date + date_adj),
    checkin_date  = checkin_date + date_adj,
    checkout_date = checkout_date + date_adj;

  return null;
end
$$ language plpgsql;

select fixup_dates();

update reservations set room_no = null where checkin_date > current_date;


