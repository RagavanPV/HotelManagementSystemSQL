CREATE VIEW `hms`.`VW_VIEW_STOCKS` 
    AS
(SELECT items,qty-IFNULL((SELECT SUM(qty_no) FROM order_details WHERE DATE(order_date)=CURDATE() AND STATUS="Ordered" AND item_id=food_schedule.`item_id`  GROUP BY item_id),0) AS Remaining FROM food_schedule 
LEFT JOIN food_types ON  food_types.id=type_id 
LEFT JOIN food_items ON food_items.`id`=food_schedule.`item_id`
GROUP BY food_schedule.id);
