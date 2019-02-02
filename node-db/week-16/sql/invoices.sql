CREATE TABLE invoices (
  id                SERIAL PRIMARY KEY,
  res_id            INTEGER NOT NULL,
  total             NUMERIC(10,2),
  invoice_date      DATE,
  paid              BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (res_id) REFERENCES reservations(id)
);

INSERT INTO invoices (res_id, total, invoice_date, paid)
  SELECT res.id,
         rm.rate * (res.checkout_date - res.checkin_date),
         res.checkout_date,
         (rm.rate * (res.checkout_date - res.checkin_date) % 11) != 2
    FROM reservations res JOIN
         rooms rm ON (res.room_no = rm.room_no)
    WHERE res.checkout_date <= CURRENT_DATE
    ORDER BY res.checkout_date;
