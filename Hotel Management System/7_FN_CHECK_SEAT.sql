/* Function  structure for function  `FN_CHECK_SEAT` */

DROP FUNCTION IF EXISTS `FN_CHECK_SEAT` ;
DELIMITER $$

CREATE FUNCTION `FN_CHECK_SEAT`(seatSno varchar(10)) RETURNS tinyint(1)
BEGIN
    declare seatValid boolean default false;
	IF EXISTS(SELECT id FROM `hotel_seat` WHERE seat_no=seatSno) THEN  
	set seatValid=true;
	end if;
	return seatValid;
    END $$
DELIMITER ;

/* Function  structure for function  `FN_CHECK_SEAT_STATUS` */

DROP FUNCTION IF EXISTS `FN_CHECK_SEAT_STATUS` ;
DELIMITER $$

CREATE FUNCTION `FN_CHECK_SEAT_STATUS`(seatSno varchar(10)) RETURNS tinyint(1)
BEGIN
	DECLARE seatValid boolean;
	SELECT STATUS into seatvalid FROM hotel_seat WHERE seat_no=seatSno;
	return seatValid;
    END $$
DELIMITER ;
