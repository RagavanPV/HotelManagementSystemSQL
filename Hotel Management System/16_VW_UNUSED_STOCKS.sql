/* View for VW_UNUSED_STOCKS */

CREATE VIEW VW_UNUSED_STOCKS AS
(SELECT
  food_items.items  AS items,
  food_schedule.qty AS qty
FROM food_items JOIN food_schedule JOIN order_details
WHERE food_items.id = food_schedule.item_id 
       AND food_items.items NOT IN (SELECT vw_ordered_stocks.items FROM vw_ordered_stocks)
GROUP BY food_items.id);