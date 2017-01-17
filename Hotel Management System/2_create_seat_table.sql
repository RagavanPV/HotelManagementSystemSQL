/*Table structure for table `hotel_seat` */

DROP TABLE IF EXISTS `hotel_seat`;

CREATE TABLE `hotel_seat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seat_no` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `seatNo` (`seat_no`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `hotel_seat` */

insert  into `hotel_seat`(`id`,`seat_no`,`status`) values (1,'S1',0),(2,'S2',0),(3,'S3',0),(4,'S4',0),(5,'S5',0),(6,'S6',0),(7,'S7',0),(8,'S8',0),(9,'S9',0),(10,'S10',0);
