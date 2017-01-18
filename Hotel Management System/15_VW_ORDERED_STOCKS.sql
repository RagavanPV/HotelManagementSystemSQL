/* View for VW_ORDERED_STOCKS */

CREATE VIEW VW_ORDERED_STOCKS AS
(SELECT
  food_items.items AS items,
  food_schedule.qty - SUM(order_details.qty_no) AS remaining
FROM food_schedule
    JOIN order_details
      ON order_details.item_id = food_schedule.item_id
   JOIN food_items
     ON food_items.id = food_schedule.item_id
WHERE DATE(order_date) = CURDATE()
GROUP BY food_items.id);