/* Procedure structure for procedure `PR_PAY_BILLS` */

DROP PROCEDURE IF EXISTS  `PR_PAY_BILLS` ;

DELIMITER $$

CREATE PROCEDURE `PR_PAY_BILLS`(in orderSno int,out message varchar(30))
BEGIN
if exists(select order_no from bill_details where date(order_date)=curdate() and order_no=orderSno) then
update bill_details set bill_status = 1 where order_no=orderSno and date(order_date)=curdate();
set message="Your bill has been paid";
else
set message='Enter a valid order Number';
end if;
	END $$
DELIMITER ;