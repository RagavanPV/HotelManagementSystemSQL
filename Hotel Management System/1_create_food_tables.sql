CREATE DATABASE /*!32312 IF NOT EXISTS*/`hms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `hms`;

/*Table structure for table `food_items` */

DROP TABLE IF EXISTS `food_items`;

CREATE TABLE `food_items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `items` varchar(200) NOT NULL,
  `price` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iItems` (`items`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `food_items` */

insert  into `food_items`(`id`,`items`,`price`) values (1,'Idly',6),(2,'Vada',6),(3,'Dosa',10),(4,'Poori',15),(5,'Pongal',30),(6,'Coffee',10),(7,'Tea',10),(8,'South Indian Meals',60),(9,'North Indian Thali',60),(10,'Variety Rice',50),(11,'Snacks',20),(12,'Fried Rice',50),(13,'Chapatti',15),(14,'Chat Items',20);
  
/*Table structure for table `food_types` */

DROP TABLE IF EXISTS `food_types`;

CREATE TABLE `food_types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(200) NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fTtype` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `food_types` */

insert  into `food_types`(`id`,`type`,`time_start`,`time_end`) values (1,'BreakFast','08:00:00','11:00:00'),(2,'Lunch','11:15:00','15:00:00'),(3,'Refreshment','15:15:00','23:00:00'),(4,'Dinner','19:00:00','23:00:00');

/*Table structure for table `food_schedule` */

DROP TABLE IF EXISTS `food_schedule`;

CREATE TABLE `food_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `qty` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Composite` (`type_id`,`item_id`),
  KEY `fk_item` (`item_id`),
  CONSTRAINT `fk_item` FOREIGN KEY (`item_id`) REFERENCES `food_items` (`id`),
  CONSTRAINT `fk_type` FOREIGN KEY (`type_id`) REFERENCES `food_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `food_schedule` */

insert  into `food_schedule`(`id`,`type_id`,`item_id`,`qty`) values (1,1,1,100),(2,1,2,100),(3,1,3,100),(4,1,4,100),(5,1,5,100),(6,1,6,100),(7,1,7,100),(8,2,8,75),(9,2,9,75),(10,2,10,75),(11,3,6,200),(12,3,7,200),(13,3,11,200),(14,4,12,100),(15,4,13,100),(16,4,14,100);
