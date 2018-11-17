CREATE TABLE rooms (
  room_no integer primary key,	-- always assigned a value
  rate NUMERIC(6,2) not null,	-- standard room rate per night
  room_type varchar(30),	-- room classification
  no_guests integer,		-- maximum people that can be accommodated
  foreign key (room_type) references room_types(room_type)
);

INSERT INTO rooms VALUES(101,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(102,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(103,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(104,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(105,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(106,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(107,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(108,98.00,'PREMIUM PLUS',2);
INSERT INTO rooms VALUES(109,98.00,'PREMIUM PLUS',2);
INSERT INTO rooms VALUES(110,98.00,'PREMIUM PLUS',2);
INSERT INTO rooms VALUES(111,98.00,'PREMIUM PLUS',2);
INSERT INTO rooms VALUES(112,98.00,'PREMIUM PLUS',2);
INSERT INTO rooms VALUES(201,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(202,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(203,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(204,85.00,'PREMIUM',2);
INSERT INTO rooms VALUES(205,85.00,'PREMIUM',3);
INSERT INTO rooms VALUES(206,85.00,'PREMIUM',3);
INSERT INTO rooms VALUES(207,85.00,'PREMIUM',3);
INSERT INTO rooms VALUES(208,98.00,'PREMIUM PLUS',2);
INSERT INTO rooms VALUES(209,98.00,'PREMIUM PLUS',2);
INSERT INTO rooms VALUES(210,98.00,'PREMIUM PLUS',2);
INSERT INTO rooms VALUES(211,98.00,'PREMIUM PLUS',3);
INSERT INTO rooms VALUES(212,98.00,'PREMIUM PLUS',3);
INSERT INTO rooms VALUES(301,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(302,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(303,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(304,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(305,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(306,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(307,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(308,123.00,'PREMIER PLUS',2);
INSERT INTO rooms VALUES(309,123.00,'PREMIER PLUS',2);
INSERT INTO rooms VALUES(310,123.00,'PREMIER PLUS',2);
INSERT INTO rooms VALUES(311,123.00,'PREMIER PLUS',2);
INSERT INTO rooms VALUES(312,123.00,'PREMIER PLUS',2);
INSERT INTO rooms VALUES(401,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(402,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(403,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(404,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(405,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(406,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(407,110.00,'PREMIER',2);
INSERT INTO rooms VALUES(408,123.00,'PREMIER PLUS',2);
INSERT INTO rooms VALUES(409,123.00,'PREMIER PLUS',2);
INSERT INTO rooms VALUES(410,123.00,'PREMIER PLUS',2);
INSERT INTO rooms VALUES(411,123.00,'FAMILY',4);
INSERT INTO rooms VALUES(412,123.00,'FAMILY',4);
