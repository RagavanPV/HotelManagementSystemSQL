/* Procedure structure for procedure `PR_PLACE_ORDER` */

DROP PROCEDURE IF EXISTS  `PR_PLACE_ORDER` ;

DELIMITER $$

CREATE PROCEDURE `PR_PLACE_ORDER`(in seatSno varchar(10),in item varchar(20),in qty int(10),out errMsg varchar(200))
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
				IF (select FN_CHECK_FOOD_SESSION(foodTypeVar,itemNoVar)) THEN
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
	
    END $$
DELIMITER ;