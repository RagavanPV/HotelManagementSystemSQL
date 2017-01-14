/*
SQLyog Ultimate v12.09 (32 bit)
MySQL - 5.6.10 : Database - hms
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `hms`;

/*Table structure for table `bill_details` */

DROP TABLE IF EXISTS `bill_details`;

CREATE TABLE `bill_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` bigint(20) NOT NULL,
  `seat_id` bigint(20) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bill_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_seat_bill` (`seat_id`),
  CONSTRAINT `fk_seat_bill` FOREIGN KEY (`seat_id`) REFERENCES `hotel_seat` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `bill_details` */

insert  into `bill_details`(`id`,`order_no`,`seat_id`,`order_date`,`bill_status`) values (7,1,1,'2017-01-14 19:02:25',1),(8,2,1,'2017-01-14 19:26:09',0);

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

/*Table structure for table `food_schedule` */

DROP TABLE IF EXISTS `food_schedule`;

CREATE TABLE `food_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Composite` (`type_id`,`item_id`),
  KEY `fk_item` (`item_id`),
  CONSTRAINT `fk_item` FOREIGN KEY (`item_id`) REFERENCES `food_items` (`id`),
  CONSTRAINT `fk_type` FOREIGN KEY (`type_id`) REFERENCES `food_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `food_schedule` */

insert  into `food_schedule`(`id`,`type_id`,`item_id`) values (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,2,8),(9,2,9),(10,2,10),(11,3,6),(12,3,7),(13,3,11),(14,4,12),(15,4,13),(16,4,14);

/*Table structure for table `food_types` */

DROP TABLE IF EXISTS `food_types`;

CREATE TABLE `food_types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(200) NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  `qty` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fTtype` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `food_types` */

insert  into `food_types`(`id`,`type`,`time_start`,`time_end`,`qty`) values (1,'BreakFast','08:00:00','11:00:00',100),(2,'Lunch','11:15:00','15:00:00',75),(3,'Refreshment','15:15:00','23:00:00',200),(4,'Dinner','19:00:00','23:00:00',100);

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `order_details` */

insert  into `order_details`(`id`,`bill_no`,`item_id`,`qty_no`,`order_date`,`status`) values (4,7,7,50,'2017-01-14 19:02:25','Ordered'),(5,7,6,40,'2017-01-14 19:02:25','Ordered'),(6,7,11,30,'2017-01-14 19:03:43','Ordered'),(7,7,13,40,'2017-01-14 19:22:55','Ordered'),(8,7,14,60,'2017-01-14 19:22:55','Ordered'),(9,7,7,10,'2017-01-14 19:25:05','Cancelled'),(10,8,7,2,'2017-01-14 19:26:09','Ordered'),(11,8,11,10,'2017-01-14 19:26:09','Ordered'),(12,8,6,10,'2017-01-14 19:26:10','Ordered'),(13,8,13,20,'2017-01-14 19:26:10','Ordered'),(14,8,12,12,'2017-01-14 19:26:10','Ordered'),(15,8,7,10,'2017-01-14 19:37:58','Cancelled');

/*Table structure for table `order_limit` */

DROP TABLE IF EXISTS `order_limit`;

CREATE TABLE `order_limit` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `max_no` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `order_limit` */

insert  into `order_limit`(`id`,`max_no`) values (1,5);

/* Function  structure for function  `FN_CHECK_ITEM` */

/*!50003 DROP FUNCTION IF EXISTS `FN_CHECK_ITEM` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `FN_CHECK_ITEM`(item varchar(30)) RETURNS tinyint(1)
BEGIN
    declare itemValid boolean default false;
	IF EXISTS(SELECT id FROM food_items WHERE items=item) THEN
		set itemValid=TRUE;
	end if;
	return itemValid;
    END */$$
DELIMITER ;

/* Function  structure for function  `FN_GET_ORDER_NUMBER` */

/*!50003 DROP FUNCTION IF EXISTS `FN_GET_ORDER_NUMBER` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `FN_GET_ORDER_NUMBER`(seatNoVar int(10)) RETURNS int(10)
BEGIN
    declare orderSno int(10);
		IF NOT EXISTS(SELECT id FROM bill_details WHERE DATE(order_date)=CURDATE()) THEN
		SET orderSno=1;
		ELSEIF EXISTS(SELECT id FROM bill_details WHERE DATE(order_date)=CURDATE() AND seat_id=seatNoVar AND bill_status=0) THEN
		SELECT MAX(order_no) INTO orderSno FROM bill_details WHERE DATE(order_date)=CURDATE() AND seat_id=seatNoVar AND bill_status=0;
		ELSE
		SELECT MAX(order_no)+1 INTO orderSno FROM bill_details WHERE DATE(order_date)=CURDATE();
		END IF;
		return orderSno;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `PR_CANCEL_ORDER` */

/*!50003 DROP PROCEDURE IF EXISTS  `PR_CANCEL_ORDER` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `PR_CANCEL_ORDER`(in seatname varchar(10),IN item VARCHAR(100),IN qty INT)
BEGIN
declare itemSno int;
declare seatSno int;
declare orderSno int;
declare billSno int;
declare presentqty int;
	IF (SELECT FN_CHECK_ITEM(item)) THEN
	SELECT id INTO itemSno FROM food_items WHERE items=item;
		if exists(select id from hotel_seat where seat_no=seatname) then
			select id into seatSno from hotel_seat where seat_no=seatname;
			select FN_GET_ORDER_NUMBER(seatSno) into orderSno;
			select id into billSno from bill_details where `order_no`=orderSno and date(order_date)=curdate();
			if exists(select id from bill_details where order_no=orderSno and date(order_date)=curdate() and bill_status=0) then
			select qty_no into presentqty from order_details where bill_no=billSno and item_id=itemSno and date(order_date) and status="Ordered";
				IF qty>0 and presentqty-qty>0 THEN
					if exists(select id from order_details where bill_no=billSno and item_id=itemSno and date(order_date)=curdate() and status="Cancelled") then
					UPDATE order_details SET qty_no=qty_no-qty WHERE bill_no=billSno AND item_id=itemSno AND DATE(order_date)=CURDATE() and status="Ordered";
					update order_details set qty_no=qty_no+qty where bill_no=billSno and item_id=itemSno and date(order_date)=curdate() and status="Cancelled";
					select "Order Cancelled";
					elseif exists(select id from order_details where bill_no=billSno and item_id=itemSno and date(order_date)=curdate()) then
					update order_details set qty_no=qty_no-qty where bill_no=billSno and item_id=itemSno and date(order_date)=curdate() and status="Ordered";
					insert into order_details(bill_no,item_id,qty_no,status) values(billSno,itemSno,qty,"Cancelled");
					select "Order Cancelled";
					else
					select "Cannot cancel";
					end if;
				else
				select "Cannot Cancel .Invalid Quantity";
				end if;
			else
			select "You cannot cancel the paid items";
			end if;
		else
		select "invalid seat no";
		end if;
	else
	select "Invalid Item";
	end if;
			
	END */$$
DELIMITER ;

/* Procedure structure for procedure `PR_PAY_BILLS` */

/*!50003 DROP PROCEDURE IF EXISTS  `PR_PAY_BILLS` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `PR_PAY_BILLS`(in orderSno int,out message varchar(30))
BEGIN
if exists(select order_no from bill_details where date(order_date)=curdate() and order_no=orderSno) then
update bill_details set bill_status = 1 where order_no=orderSno and date(order_date)=curdate();
set message="Your bill has been paid";
else
set message='Enter a valid order Number';
end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `PR_PLACE_ORDER` */

/*!50003 DROP PROCEDURE IF EXISTS  `PR_PLACE_ORDER` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `PR_PLACE_ORDER`(in seatSno varchar(10),in item varchar(20),in qty int(10),out errMsg varchar(200))
BEGIN
	DECLARE itemNoVar INT;
	DECLARE foodTypeVar INT;
	DECLARE qtyVar INT;
	DECLARE seatNoVar INT;
	DECLARE qtyConsume INT;
	DECLARE orderSno INT;
	declare billSno int;
	DECLARE taken INT;
	DECLARE orderCount INT;
	
	if (select FN_CHECK_ITEM(item)) then
			IF qty>0 THEN
			SELECT id INTO itemNoVar FROM `food_items` WHERE items=item;#food item id
			SELECT type_id INTO foodTypeVar FROM food_schedule WHERE type_id IN (SELECT id FROM `food_types` WHERE time_start<=CURTIME() AND time_end>=CURTIME()) AND item_id=itemNoVar;
			SELECT food_types.qty INTO qtyVar FROM food_types WHERE id=foodTypeVar;#seed quantity
			SELECT id INTO seatNoVar FROM `hotel_seat` WHERE seat_no=seatSno;#seat id
			SELECT SUM(qty_no) INTO qtyConsume FROM order_details WHERE item_id=itemNoVar AND STATUS="ordered" AND DATE(order_date)=CURDATE();#item Consumed
			
/*Generate order number*/SELECT FN_GET_ORDER_NUMBER(seatNoVar) INTO orderSno;
				IF EXISTS(SELECT id FROM food_schedule WHERE type_id=foodTypeVar AND item_id=itemNoVar) THEN
				SELECT COUNT(*) INTO orderCount FROM order_details join bill_details on order_details.bill_no=bill_details.`id` WHERE bill_details.`order_no`=orderSno AND STATUS="ordered" AND DATE(order_details.order_date)=CURDATE();
				SELECT qty_no INTO taken FROM order_details join bill_details on order_details.`bill_no`=bill_details.id WHERE bill_details.`order_no`=orderSno AND STATUS="ordered" AND item_id=itemNoVar AND DATE(order_details.order_date)=CURDATE();
				IF NOT EXISTS(SELECT id FROM bill_details WHERE order_no=orderSno AND DATE(order_date)=CURDATE()) THEN
				INSERT INTO bill_details(order_no,seat_id) VALUES(orderSno,seatNoVar);
				END IF;
				SELECT id INTO billSno FROM bill_details WHERE bill_details.`order_no`=orderSno AND DATE(order_date)=CURDATE();
				
					IF EXISTS(SELECT order_details.id FROM order_details join bill_details on order_details.`bill_no`=bill_details.`id` WHERE order_no=orderSno AND item_id=itemNoVar AND DATE(order_details.order_date)=CURDATE()) THEN
						IF qtyVar>=qtyConsume+qty AND taken IS NOT NULL THEN	
						UPDATE order_details SET qty_no=qty+taken WHERE bill_no=billSno AND item_id=itemNoVar AND DATE(order_date)=CURDATE() AND STATUS="ordered";
						SELECT CONCAT("Your order has been taken Please wait for some time and Order Number is ",orderSno);
						ELSE
						SELECT CONCAT("We dont have enough quantity.We have ",qtyVar-qtyConsume," remaining");
						END IF;
					else
						IF qtyVar>=qtyConsume+Qty OR qtyConsume IS NULL THEN
							IF orderCount< (SELECT max_no FROM order_limit) THEN
							INSERT INTO order_details(bill_no,item_id,qty_no) VALUES(billSno,itemNoVar,Qty);
							SELECT CONCAT("Your order has been taken Please wait for some time and order Number is ",orderSno);
							ELSE
							SELECT "You can only order 5 items per order";
							END IF;
						ELSE
						SELECT CONCAT("We dont have enough quantity.We have ",qtyVar-qtyConsume," remaining");
						END IF;
					
					end if;	
				else
				set errMsg="We dont prepare the item now";
				end if;
			else
			set errMsg="Enter a valid quantity";
			end if;
	
	else
	set errMsg="Invalid Item Name";
	end if;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `PR_PLACE_ORDERS` */

/*!50003 DROP PROCEDURE IF EXISTS  `PR_PLACE_ORDERS` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `PR_PLACE_ORDERS`(in seatSno varchar(10),IN itemList MEDIUMTEXT,IN quantityList MEDIUMTEXT)
BEGIN
          DECLARE nextItem TEXT DEFAULT NULL ;
          DECLARE nextQuantity TEXT DEFAULT NULL;
          DECLARE nextQuantityLength INT DEFAULT NULL;
          DECLARE nextItemLength INT DEFAULT NULL;
          DECLARE nextItemValue TEXT DEFAULT NULL;
          DECLARE nextQuantityValue TEXT DEFAULT NULL;
          IF EXISTS(SELECT id FROM `hotel_seat` WHERE seat_no=seatSno) THEN  
          if (select status from hotel_seat where seat_no=seatSno) then
          select "Seat Is taken Please wait";
          else
		  start Transaction;
		  set autocommit=0;
		  Update hotel_seat set status=1 where seat_no=seatSno;
		 iterator :
		 LOOP    
		    IF LENGTH(TRIM(itemList)) = 0 OR itemList IS NULL THEN
		      LEAVE iterator;
		      END IF;
			 SET nextItem = SUBSTRING_INDEX(itemList,',',1);
			 SET nextQuantity=SUBSTRING_INDEX(quantityList,',',1);
			 SET nextItemLength = LENGTH(nextItem);
			 SET nextQuantityLength = LENGTH(nextQuantity);
			 SET nextItemValue = TRIM(nextItem);
			 SET nextQuantityValue= TRIM(nextQuantity);   
			 
			 call PR_PLACE_ORDER(seatSno,nextItem,nextQuantity,@out);
			
			 SET itemList = INSERT(itemList,1,nextItemLength + 1,'');
			 SET quantityList = INSERT(quantityList,1,nextQuantityLength + 1,'');
			 
		   END LOOP;   
		   commit;
		   UPDATE hotel_seat SET STATUS=0 WHERE seat_no=seatSno;
	    end if;
            ELSE
            SELECT "Invalid Seat No";
            end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `PR_VIEW_STOCKS` */

/*!50003 DROP PROCEDURE IF EXISTS  `PR_VIEW_STOCKS` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `PR_VIEW_STOCKS`()
BEGIN
/*	DECLARE tot INT;
	DECLARE frmTime TIME;
	DECLARE toTime TIME;
	SELECT qty INTO tot FROM food_types WHERE time_start<=curtime() AND time_end>=curTIME();
	SELECT time_start INTO frmTime FROM food_types WHERE time_start<=CURTIME() AND time_end>=CURTIME();
	SELECT time_end INTO toTime FROM food_types WHERE time_start<=CURTIME() AND time_end>=CURTIME();
	SELECT items AS Items,SUM(qtyNo) AS Sold,tot-SUM(qtyNo) AS Remaining FROM order_details JOIN food_items ON item_id=food_items.id WHERE DATE(order_date)=curdate() AND TIME(order_date) BETWEEN frmTime AND toTime GROUP BY item_id;*/
	
	select items as item_name,sum(order_details.qty_no)AS sold ,food_types.qty as total from order_details join food_items on item_id=food_items.id join food_schedule on food_schedule.item_id=food_items.id join food_types on type_id=food_types.id where date(order_date)=curdate() and order_details.`status`='Ordered' group by order_details.item_id;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
