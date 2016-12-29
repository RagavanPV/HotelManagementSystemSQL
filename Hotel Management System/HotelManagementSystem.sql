/*
SQLyog Trial v12.3.2 (32 bit)
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

/*Table structure for table `fooditems` */

DROP TABLE IF EXISTS `fooditems`;

CREATE TABLE `fooditems` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `iItems` varchar(200) NOT NULL,
  `iPrice` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iItems` (`iItems`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `fooditems` */

insert  into `fooditems`(`id`,`iItems`,`iPrice`) values 

(1,'Idly',6),

(2,'Vada',6),

(3,'Dosa',10),

(4,'Poori',15),

(5,'Pongal',30),

(6,'Coffee',10),

(7,'Tea',10),

(8,'South Indian Meals',60),

(9,'North Indian Thali',60),

(10,'Variety Rice',50),

(11,'Snacks',20),

(12,'Fried Rice',50),

(13,'Chapatti',15),

(14,'Chat Items',20);

/*Table structure for table `foodschedule` */

DROP TABLE IF EXISTS `foodschedule`;

CREATE TABLE `foodschedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `typeId` bigint(20) NOT NULL,
  `itemId` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Composite` (`typeId`,`itemId`),
  KEY `fk_item` (`itemId`),
  CONSTRAINT `fk_item` FOREIGN KEY (`itemId`) REFERENCES `fooditems` (`id`),
  CONSTRAINT `fk_type` FOREIGN KEY (`typeId`) REFERENCES `foodtypes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `foodschedule` */

insert  into `foodschedule`(`id`,`typeId`,`itemId`) values 

(1,1,1),

(2,1,2),

(3,1,3),

(4,1,4),

(5,1,5),

(6,1,6),

(7,1,7),

(8,2,8),

(9,2,9),

(10,2,10),

(11,3,6),

(12,3,7),

(13,3,11),

(14,4,12),

(15,4,13),

(16,4,14);

/*Table structure for table `foodtypes` */

DROP TABLE IF EXISTS `foodtypes`;

CREATE TABLE `foodtypes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fType` varchar(200) NOT NULL,
  `fTimeStart` time NOT NULL,
  `fTimeEnd` time NOT NULL,
  `Qty` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fTtype` (`fType`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `foodtypes` */

insert  into `foodtypes`(`id`,`fType`,`fTimeStart`,`fTimeEnd`,`Qty`) values 

(1,'BreakFast','08:00:00','11:00:00',100),

(2,'Lunch','11:15:00','15:00:00',75),

(3,'Refreshment','15:15:00','23:00:00',200),

(4,'Dinner','19:00:00','23:00:00',100);

/*Table structure for table `hotelseat` */

DROP TABLE IF EXISTS `hotelseat`;

CREATE TABLE `hotelseat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seatNo` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `seatNo` (`seatNo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `hotelseat` */

insert  into `hotelseat`(`id`,`seatNo`,`status`) values 

(1,'S1',1),

(2,'S2',1),

(3,'S3',1),

(4,'S4',1),

(5,'S5',1),

(6,'S6',1),

(7,'S7',1),

(8,'S8',1),

(9,'S9',1),

(10,'S10',1);

/*Table structure for table `orderdetails` */

DROP TABLE IF EXISTS `orderdetails`;

CREATE TABLE `orderdetails` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderNo` bigint(20) NOT NULL,
  `seatId` bigint(20) NOT NULL,
  `itemId` bigint(20) NOT NULL,
  `qtyNo` bigint(20) NOT NULL,
  `orderDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `billStatus` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_seat_order` (`seatId`),
  KEY `fk_item_order` (`itemId`),
  CONSTRAINT `fk_item_order` FOREIGN KEY (`itemId`) REFERENCES `fooditems` (`id`),
  CONSTRAINT `fk_seat_order` FOREIGN KEY (`seatId`) REFERENCES `hotelseat` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

/*Data for the table `orderdetails` */

insert  into `orderdetails`(`id`,`orderNo`,`seatId`,`itemId`,`qtyNo`,`orderDate`,`billStatus`) values 

(68,1,1,13,6,'2016-12-29 22:02:29',0),

(69,1,1,14,90,'2016-12-29 22:02:29',0),

(70,1,1,12,8,'2016-12-29 22:02:29',0),

(71,1,1,1,100,'2016-12-29 09:29:07',0),

(72,1,1,2,45,'2016-12-29 09:30:41',0),

(73,2,2,12,8,'2016-12-29 19:57:10',1),

(74,2,2,7,45,'2016-12-29 19:57:38',1),

(75,3,2,7,12,'2016-12-29 15:20:29',0),

(76,3,2,6,6,'2016-12-29 15:21:24',0),

(77,3,2,11,6,'2016-12-29 15:21:41',0),

(78,3,2,12,6,'2016-12-29 19:22:29',0),

(79,3,2,13,18,'2016-12-29 19:22:51',0);

/*Table structure for table `orderlimit` */

DROP TABLE IF EXISTS `orderlimit`;

CREATE TABLE `orderlimit` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `maxno` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `orderlimit` */

insert  into `orderlimit`(`id`,`maxno`) values 

(1,5);

/* Procedure structure for procedure `CancelOrders` */

/*!50003 DROP PROCEDURE IF EXISTS  `CancelOrders` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelOrders`(IN seatSno VARCHAR(10),IN orderSno INT,IN item VARCHAR(100),IN qty INT)
BEGIN

	IF EXISTS(SELECT id FROM fooditems WHERE iItems=item) THEN

		IF EXISTS(SELECT id FROM `hotelseat` WHERE seatNo=seatSno) THEN

			IF qty>0 THEN

				if exists(select id from orderdetails where orderNO=orderSno and itemId=itemSno and date(orderDate)=curdate()) then

				select "Cancelled";

				else

				select "Cannot cancel";

				end if;

			else

			select "Invalid Quantity";

			end if;

		else

		select "Invalid hotel seat";

		end if;

	else

	select "Invalid Item";

	end if;

			

	END */$$
DELIMITER ;

/* Procedure structure for procedure `PayBills` */

/*!50003 DROP PROCEDURE IF EXISTS  `PayBills` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `PayBills`(in orderSno int)
BEGIN

if exists(select orderNo from orderDetails where date(orderDate)=curdate()) then

update orderdetails set billStatus = 1 where orderNo=orderSno and date(orderDate)=curdate();

end if;



	END */$$
DELIMITER ;

/* Procedure structure for procedure `placeorder` */

/*!50003 DROP PROCEDURE IF EXISTS  `placeorder` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `placeorder`(in seatSno varchar(10),IN itemList MEDIUMTEXT,IN quantityList MEDIUMTEXT)
BEGIN

          DECLARE nextItem TEXT DEFAULT NULL ;

          DECLARE nextQuantity TEXT DEFAULT NULL;

          DECLARE nextQuantityLength INT DEFAULT NULL;

          DECLARE nextItemLength INT DEFAULT NULL;

          DECLARE nextItemValue TEXT DEFAULT NULL;

          DECLARE nextQuantityValue TEXT DEFAULT NULL;

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

                   call PlaceOrders(seatSno,nextItem,nextQuantity);

                 SET itemList = INSERT(itemList,1,nextItemLength + 1,'');

                 SET quantityList = INSERT(quantityList,1,nextQuantityLength + 1,'');

                 

           END LOOP;   

    END */$$
DELIMITER ;

/* Procedure structure for procedure `PlaceOrders` */

/*!50003 DROP PROCEDURE IF EXISTS  `PlaceOrders` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `PlaceOrders`(in seatSno varchar(10),in item varchar(100),in qty int)
BEGIN

	DECLARE itemNoVar INT;

	DECLARE foodTypeVar INT;

	DECLARE qtyVar INT;

	DECLARE seatNoVar INT;

	DECLARE qtyConsume INT;

	declare orderSno int;

	DECLARE taken INT;

	DECLARE orderCount INT;

	IF EXISTS(SELECT id FROM fooditems WHERE iItems=item) THEN

		IF EXISTS(SELECT id FROM `hotelseat` WHERE seatNo=seatSno) THEN

			if qty>0 then

			SELECT id INTO itemNoVar FROM `fooditems` WHERE iItems=item;#food item id

			SELECT typeId into foodTypeVar FROM foodschedule WHERE typeId IN (SELECT id FROM `foodtypes` WHERE fTimeStart<=CURTIME() AND fTimeEnd>=CURTIME()) AND itemId=itemNoVar;

			SELECT foodtypes.Qty INTO qtyVar FROM foodtypes WHERE id=foodTypeVar;#seed quantity

			SELECT id INTO seatNoVar FROM `hotelseat` WHERE seatNo=seatSno;#seat id

			SELECT SUM(qtyNo) INTO qtyConsume FROM orderdetails WHERE itemId=itemNoVar AND DATE(orderDate)=CURDATE();#item Consumed

			IF NOT EXISTS(SELECT id FROM orderdetails WHERE DATE(orderDate)=CURDATE()) THEN

			SET orderSno=1;

			ELSEIF EXISTS(SELECT id FROM orderdetails WHERE DATE(orderDate)=CURDATE() AND seatId=seatNoVar AND billStatus=0) then

			SELECT MAX(orderNo) INTO orderSno FROM orderdetails WHERE DATE(orderDate)=CURDATE() AND seatId=seatNoVar AND billStatus=0;

			ELSE

			SELECT MAX(orderNo)+1 INTO orderSno FROM orderdetails WHERE DATE(orderDate)=CURDATE();

			END IF;

				IF EXISTS(SELECT id FROM foodschedule WHERE typeId=foodTypeVar AND itemId=itemNoVar) THEN

				SELECT COUNT(*) INTO orderCount FROM orderdetails WHERE orderNo=orderSno AND DATE(orderDate)=CURDATE();

				SELECT qtyNo INTO taken FROM orderdetails WHERE orderNo=orderSno AND itemId=itemNoVar AND DATE(orderDate)=CURDATE();



					

						if exists(select id from orderdetails where orderNo=orderSno and itemId=itemNoVar and date(orderDate)=curdate()) then

							IF qtyVar>=qtyConsume+qty AND taken IS NOT NULL THEN	

							UPDATE orderdetails SET qtyNo=qty+taken WHERE orderNo=orderSno AND itemId=itemNoVar AND DATE(orderDate)=curdate();

							SELECT CONCAT("Your order has been taken Please wait for some time and orderNumber is ",orderSno);

							ELSE

							SELECT CONCAT("We dont have enough quantity.We have ",qtyVar-qtyConsume," remaining");

							END IF;

						else

							if qtyVar>=qtyConsume+Qty OR qtyConsume IS NULL THEN

								IF orderCount< (SELECT maxno FROM orderlimit) THEN

								INSERT INTO orderdetails(orderNo,seatId,itemId,qtyNo) VALUES(orderSno,seatNoVar,itemNoVar,Qty);

								SELECT concat("Your order has been taken Please wait for some time and orderNumber is",orderSno);

								ELSE

								SELECT "You can only order 5 items per order";

								END IF;

							ELSE

							SELECT CONCAT("We dont have enough quantity.We have ",qtyVar-qtyConsume," remaining");

							end if;

						end if;

					

				else

				select concat("We dont serve ",item," at this session");

				end if;

			else

			select "Provide a valid quantity";

			end if;

		

		else

		select "Invalid seat Number";

		end if;

	else

	select "We dont prepare such items here";

	end if;

	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
