/* Function  structure for function  `FN_GET_ORDER_NUMBER` */

DROP FUNCTION IF EXISTS `FN_GET_ORDER_NUMBER` ;
DELIMITER $$

CREATE FUNCTION `FN_GET_ORDER_NUMBER`(seatNoVar int(10)) RETURNS int(10)
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
    END $$
DELIMITER ;