/* Procedure structure for procedure `PR_VIEW_STOCKS` */

DROP PROCEDURE IF EXISTS  `PR_VIEW_STOCKS`;

DELIMITER $$

CREATE PROCEDURE `PR_VIEW_STOCKS`()
BEGIN
DECLARE tot INT;
	DECLARE frmTime TIME;
	DECLARE toTime TIME;
	SELECT qty INTO tot FROM food_types WHERE time_start<=curtime() AND time_end>=curTIME();
	SELECT time_start INTO frmTime FROM food_types WHERE time_start<=CURTIME() AND time_end>=CURTIME();
	SELECT time_end INTO toTime FROM food_types WHERE time_start<=CURTIME() AND time_end>=CURTIME();
	SELECT items AS Items,SUM(qtyNo) AS Sold,tot-SUM(qtyNo) AS Remaining FROM order_details JOIN food_items ON item_id=food_items.id WHERE DATE(order_date)=curdate() AND TIME(order_date) BETWEEN frmTime AND toTime GROUP BY item_id;*/
	
	select items as item_name,sum(order_details.qty_no)AS sold ,food_types.qty as total from order_details join food_items on item_id=food_items.id join food_schedule on food_schedule.item_id=food_items.id join food_types on type_id=food_types.id where date(order_date)=curdate() and order_details.`status`='Ordered' group by order_details.item_id;
    END $$
DELIMITER ;