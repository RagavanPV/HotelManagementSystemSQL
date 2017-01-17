/* Function  structure for function  `FN_CHECK_FOOD_SESSION` */

DROP FUNCTION IF EXISTS `FN_CHECK_FOOD_SESSION` ;
DELIMITER $$

CREATE FUNCTION `FN_CHECK_FOOD_SESSION`(foodTypeVar int,itemNoVar int) RETURNS tinyint(1)
BEGIN
    declare validItem boolean default false;
	IF EXISTS(SELECT id FROM food_schedule WHERE type_id=foodTypeVar AND item_id=itemNoVar) THEN
	set validItem=TRUE;
	end if;
	return validItem;
    END $$
DELIMITER ;