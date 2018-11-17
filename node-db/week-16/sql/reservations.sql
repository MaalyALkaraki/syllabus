CREATE TABLE reservations (
  id            SERIAL PRIMARY KEY,
  cust_id       INTEGER NOT NULL,
  room_no       INTEGER,
  checkin_date  DATE NOT NULL,
  checkout_date DATE,
  no_guests     INTEGER,
  booking_date  DATE,
  CONSTRAINT res_guest_fk FOREIGN KEY (cust_id) REFERENCES customers(id),
  CONSTRAINT res_room_fk  FOREIGN KEY (room_no) REFERENCES rooms(room_no)
);

INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(3,'2018-06-19',204,'2018-06-22',1,'2018-06-02');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(4,'2018-07-09',311,'2018-07-11',2,'2018-06-26');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(4,'2018-07-16',312,'2018-07-19',2,'2018-06-26');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(5,'2018-06-21',104,'2018-06-23',2,'2018-06-01');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(6,'2018-06-25',211,'2018-06-28',2,'2018-05-27');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(119,'2018-08-22',101,'2018-08-27',2,'2018-07-31');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(102,'2018-06-23',202,'2018-06-28',2,'2018-06-14');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(115,'2018-06-01',106,'2018-06-04',1,'2018-05-04');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(64,'2018-08-19',402,'2018-08-22',2,'2018-08-03');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(2,'2018-06-14',208,'2018-06-20',2,'2018-06-09');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(86,'2018-06-20',108,'2018-06-21',1,'2018-05-25');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(31,'2018-08-31',302,'2018-09-02',1,'2018-08-02');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(25,'2018-06-25',206,'2018-06-28',2,'2018-06-15');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(32,'2018-08-10',405,'2018-08-11',1,'2018-07-20');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(30,'2018-07-10',404,'2018-07-11',1,'2018-06-11');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(83,'2018-08-02',103,'2018-08-04',1,'2018-07-22');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(25,'2018-06-30',103,'2018-07-04',1,'2018-06-15');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(15,'2018-06-13',201,'2018-06-15',2,'2018-05-23');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(131,'2018-07-21',301,'2018-07-27',2,'2018-06-24');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(117,'2018-07-22',101,'2018-07-26',2,'2018-07-06');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(51,'2018-08-07',107,'2018-08-11',1,'2018-08-01');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(25,'2018-06-19',109,'2018-06-21',1,'2018-05-26');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(46,'2018-08-04',301,'2018-08-08',2,'2018-07-19');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(38,'2018-07-20',411,'2018-07-22',2,'2018-07-07');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(19,'2018-08-04',312,'2018-08-09',2,'2018-07-11');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(97,'2018-06-22',210,'2018-06-28',2,'2018-06-22');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(76,'2018-08-22',102,'2018-08-24',2,'2018-08-16');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(108,'2018-08-27',308,'2018-08-30',1,'2018-08-11');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(51,'2018-06-09',409,'2018-06-10',2,'2018-06-02');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(82,'2018-08-28',305,'2018-08-30',1,'2018-08-09');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(77,'2018-06-14',112,'2018-06-15',1,'2018-05-16');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(52,'2018-07-24',305,'2018-07-25',1,'2018-07-11');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(14,'2018-08-31',301,'2018-09-02',1,'2018-08-26');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(23,'2018-07-14',304,'2018-07-15',1,'2018-06-28');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(114,'2018-06-12',203,'2018-06-16',1,'2018-06-05');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(58,'2018-06-20',110,'2018-06-25',2,'2018-06-15');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(30,'2018-06-05',408,'2018-06-06',1,'2018-05-25');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(129,'2018-07-04',306,'2018-07-05',2,'2018-06-13');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(129,'2018-07-03',206,'2018-07-05',2,'2018-06-28');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(123,'2018-08-31',312,'2018-09-04',1,'2018-08-24');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(20,'2018-07-03',410,'2018-07-08',2,'2018-06-11');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(110,'2018-08-10',301,'2018-08-11',2,'2018-07-13');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(104,'2018-06-01',309,'2018-06-07',2,'2018-05-24');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(5,'2018-06-17',311,'2018-06-22',2,'2018-06-08');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(9,'2018-07-15',305,'2018-07-21',1,'2018-07-08');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(104,'2018-06-15',301,'2018-06-16',1,'2018-06-01');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(31,'2018-08-03',111,'2018-08-04',1,'2018-07-11');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(54,'2018-06-21',111,'2018-06-26',2,'2018-06-03');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(16,'2018-08-01',308,'2018-08-07',1,'2018-07-30');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(37,'2018-06-23',402,'2018-06-28',2,'2018-06-02');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(117,'2018-08-20',206,'2018-08-21',1,'2018-08-19');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(115,'2018-06-08',203,'2018-06-11',1,'2018-05-06');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(126,'2018-09-02',104,'2018-09-07',1,'2018-08-07');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(97,'2018-08-15',404,'2018-08-18',1,'2018-07-29');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(109,'2018-06-19',202,'2018-06-21',1,'2018-06-14');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(91,'2018-07-21',211,'2018-07-26',2,'2018-07-10');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(97,'2018-07-12',309,'2018-07-14',1,'2018-06-18');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(88,'2018-07-16',206,'2018-07-17',1,'2018-07-13');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(30,'2018-05-30',109,'2018-06-05',1,'2018-05-19');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(20,'2018-08-27',311,'2018-08-31',1,'2018-08-19');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(77,'2018-06-21',110,'2018-06-24',2,'2018-06-11');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(121,'2018-06-04',312,'2018-06-05',1,'2018-05-28');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(15,'2018-08-04',307,'2018-08-08',1,'2018-07-18');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(79,'2018-08-07',303,'2018-08-10',2,'2018-07-30');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(80,'2018-06-02',107,'2018-06-06',2,'2018-05-29');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(40,'2018-09-02',310,'2018-09-05',1,'2018-08-06');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(9,'2018-08-22',105,'2018-08-25',1,'2018-08-22');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(64,'2018-06-12',104,'2018-06-18',1,'2018-06-12');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(43,'2018-05-30',204,'2018-06-04',2,'2018-05-05');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(26,'2018-08-09',205,'2018-08-12',1,'2018-07-19');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(41,'2018-07-26',302,'2018-07-31',2,'2018-07-03');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(75,'2018-06-17',111,'2018-06-21',2,'2018-06-01');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(65,'2018-06-12',411,'2018-06-14',2,'2018-05-30');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(96,'2018-08-25',205,'2018-08-31',1,'2018-08-22');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(14,'2018-06-29',303,'2018-07-05',1,'2018-06-16');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(35,'2018-08-09',411,'2018-08-14',2,'2018-07-17');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(115,'2018-06-11',202,'2018-06-13',1,'2018-05-27');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(119,'2018-08-26',303,'2018-08-28',2,'2018-08-12');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(38,'2018-08-07',210,'2018-08-12',2,'2018-08-07');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(96,'2018-08-22',106,'2018-08-27',1,'2018-08-19');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(24,'2018-08-07',402,'2018-08-08',1,'2018-07-25');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(106,'2018-07-24',206,'2018-07-29',1,'2018-07-10');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(130,'2018-06-20',209,'2018-06-21',1,'2018-05-29');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(84,'2018-06-14',111,'2018-06-16',2,'2018-06-03');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(108,'2018-06-29',405,'2018-06-30',2,'2018-06-14');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(12,'2018-08-26',401,'2018-08-29',1,'2018-08-06');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(67,'2018-07-18',401,'2018-07-19',1,'2018-07-01');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(63,'2018-08-12',412,'2018-08-17',1,'2018-08-07');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(2,'2018-06-09',412,'2018-06-11',2,'2018-06-05');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(66,'2018-07-31',305,'2018-08-03',1,'2018-07-25');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(9,'2018-06-19',102,'2018-06-20',1,'2018-06-04');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(44,'2018-07-29',410,'2018-08-02',2,'2018-07-12');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(129,'2018-08-02',203,'2018-08-06',1,'2018-07-17');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(29,'2018-06-24',212,'2018-06-27',1,'2018-06-18');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(55,'2018-09-02',311,'2018-09-06',2,'2018-08-27');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(13,'2018-06-29',104,'2018-06-30',2,'2018-06-04');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(116,'2018-08-18',302,'2018-08-20',1,'2018-08-12');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(70,'2018-06-20',404,'2018-06-22',1,'2018-06-08');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(49,'2018-06-30',402,'2018-07-04',1,'2018-06-05');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(18,'2018-07-18',211,'2018-07-20',2,'2018-07-01');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(95,'2018-06-02',411,'2018-06-07',1,'2018-05-25');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(93,'2018-08-11',207,'2018-08-15',1,'2018-07-24');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(13,'2018-06-19',405,'2018-06-21',1,'2018-05-24');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(98,'2018-08-30',207,'2018-09-05',2,'2018-08-23');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(108,'2018-08-24',303,'2018-08-26',1,'2018-08-05');
INSERT INTO reservations (cust_id,checkin_date,room_no,checkout_date,no_guests,booking_date) VALUES(84,'2018-07-03',401,'2018-07-09',1,'2018-06-21');
