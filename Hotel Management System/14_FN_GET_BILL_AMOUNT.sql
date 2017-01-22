/* function  structure for function  `FN_GET_BILL_AMOUNT` */

drop function if exists `FN_GET_BILL_AMOUNT`;
delimiter $$

create function `FN_GET_BILL_AMOUNT`(orderSno int) returns int(11)
begin
    declare cost int;
    declare billSno int;
    select id into billSno from bill_details where order_no=orderSno and date(order_date)=curdate();
select sum(qty_no*food_items.price) into cost from order_details join food_items on food_items.`id`=order_details.`item_id` where order_details.`bill_no`=billSno group by order_details.`bill_no`;
return cost;
    end $$
delimiter ;
