/*Table structure for table `bill_details` */

DROP TABLE IF EXISTS `bill_details`;

CREATE TABLE `bill_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` bigint(20) NOT NULL,
  `seat_id` bigint(20) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bill_status` tinyint(1) NOT NULL DEFAULT '0',
  `total_price` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_seat_bill` (`seat_id`),
  CONSTRAINT `fk_seat_bill` FOREIGN KEY (`seat_id`) REFERENCES `hotel_seat` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Table structure for table `order_details` */

DROP TABLE IF EXISTS `order_details`;

CREATE TABLE `order_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `qty_no` bigint(20) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) NOT NULL DEFAULT 'Ordered',
  PRIMARY KEY (`id`),
  KEY `fk_item_order` (`item_id`),
  KEY `fk_bill_no` (`bill_no`),
  CONSTRAINT `fk_bill_no` FOREIGN KEY (`bill_no`) REFERENCES `bill_details` (`id`),
  CONSTRAINT `fk_item_id` FOREIGN KEY (`item_id`) REFERENCES `food_items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Table structure for table `order_limit` */

DROP TABLE IF EXISTS `order_limit`;

CREATE TABLE `order_limit` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `max_no` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `order_limit` */

insert  into `order_limit`(`id`,`max_no`) values (1,5);