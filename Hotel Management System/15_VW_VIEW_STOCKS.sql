CREATE VIEW `hms`.`VW_VIEW_STOCKS` 
    AS
(SELECT TYPE,items ,qty, IFNULL(SUM(qty_no),0) AS Sold, qty-IFNULL(SUM(qty_no),0) AS Remaining FROM food_schedule fs
LEFT JOIN food_items fi ON fs.`item_id`=fi.`id`
LEFT JOIN food_types ft ON fs.`type_id`=ft.`id`
LEFT JOIN order_details od ON od.`item_id`=fi.`id` 
AND EXISTS(SELECT 1 FROM food_types WHERE id=ft.id AND TIME(od.order_date) BETWEEN time_start AND time_end)
AND DATE(od.order_date)=CURDATE()
GROUP BY fi.id,fs.`type_id`
ORDER BY ft.id ASC ,fi.id ASC);
