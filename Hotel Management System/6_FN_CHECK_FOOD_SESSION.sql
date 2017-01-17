/* Function  structure for function  `FN_CHECK_FOOD_SESSION` */

DROP FUNCTION IF EXISTS `FN_CHECK_FOOD_SESSION`;
DELIMITER $$

CREATE FUNCTION `FN_CHECK_FOOD_SESSION`(item varchar(40)) RETURNS tinyint(1)
BEGIN
    declare validItem boolean default false;
    declare itemNoVar int;
    declare foodTypeVar int;
    SELECT id INTO itemNoVar FROM `food_items` WHERE items=item;
    SELECT type_id INTO foodTypeVar FROM food_schedule WHERE type_id IN (SELECT id FROM `food_types` WHERE time_start<=CURTIME() AND time_end>=CURTIME()) AND item_id=itemNoVar;
	IF EXISTS(SELECT id FROM food_schedule WHERE type_id=foodTypeVar AND item_id=itemNoVar) THEN
	set validItem=TRUE;
	end if;
	return validItem;
    END $$
DELIMITER ;