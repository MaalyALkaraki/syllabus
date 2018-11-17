CREATE TABLE room_types (
    room_type           VARCHAR(30) PRIMARY KEY,
    def_rate            NUMERIC(6,2)
);

INSERT INTO room_types VALUES('FAMILY',123.00);
INSERT INTO room_types VALUES('PREMIER',110.00);
INSERT INTO room_types VALUES('PREMIER PLUS',123.00);
INSERT INTO room_types VALUES('PREMIUM',85.00);
INSERT INTO room_types VALUES('PREMIUM PLUS',98.00);
