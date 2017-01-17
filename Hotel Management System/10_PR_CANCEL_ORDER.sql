/* Procedure structure for procedure `PR_CANCEL_ORDER` */

DROP PROCEDURE IF EXISTS  `PR_CANCEL_ORDER`;

DELIMITER $$

CREATE PROCEDURE `PR_CANCEL_ORDER`(in seatname varchar(10),IN item VARCHAR(100),IN qty INT)
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
			
	END $$
DELIMITER ;