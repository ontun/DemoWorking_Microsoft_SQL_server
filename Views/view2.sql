CREATE VIEW Client_orders AS
SELECT Purchase.Purchase_date_time, Menu.Dish_name, Menu.Dish_price, Client.Client_first_name, Client.Client_last_name
FROM Purchase
JOIN Dish_in_order ON Purchase.Purchase_id = Dish_in_order.Purchase_id
JOIN Menu ON Dish_in_order.Dish_id = Menu.Dish_id
JOIN Client ON Purchase.Client_id = Client.Client_id;
