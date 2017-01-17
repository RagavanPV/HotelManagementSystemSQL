/* Function  structure for function  `FN_GET_QTY` */

DROP FUNCTION IF EXISTS `FN_GET_QTY` ;
DELIMITER $$

CREATE FUNCTION `FN_GET_QTY`(item varchar(40)) RETURNS int(11)
BEGIN
    declare foodTypeVar int;
    declare qtyVar int;
    declare itemNoVar int;
	SELECT id INTO itemNoVar FROM `food_items` WHERE items=item;#food item id
	SELECT type_id INTO foodTypeVar FROM food_schedule WHERE type_id IN (SELECT id FROM `food_types` WHERE time_start<=CURTIME() AND time_end>=CURTIME()) AND item_id=itemNoVar;
	SELECT food_schedule.qty INTO qtyVar FROM food_schedule WHERE type_id=foodTypeVar AND item_id=itemNoVar;#seed quantity
	return qtyVar;
    END $$
DELIMITER ;
