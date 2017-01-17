/* Function  structure for function  `FN_CHECK_ITEM` */

DROP FUNCTION IF EXISTS `FN_CHECK_ITEM`;
DELIMITER $$

CREATE FUNCTION `FN_CHECK_ITEM`(item varchar(30)) RETURNS tinyint(1)
BEGIN
    declare itemValid boolean default false;
	IF EXISTS(SELECT id FROM food_items WHERE items=item) THEN
		set itemValid=TRUE;
	end if;
	return itemValid;
    END $$
DELIMITER ;
