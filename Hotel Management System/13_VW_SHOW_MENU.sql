CREATE VIEW `hms`.`VW_SHOW_MENU` 
    AS
(SELECT TYPE,items,price FROM food_items JOIN food_schedule ON food_items.id=food_schedule.item_id JOIN food_types ON food_types.id=type_id);
