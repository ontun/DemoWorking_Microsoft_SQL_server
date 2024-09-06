SELECT Purchase.Purchase_date_time, Client.Client_first_name, Client.Client_last_name, Menu.Dish_name
FROM Purchase
LEFT JOIN Client ON Purchase.Client_id = Client.Client_id
LEFT JOIN Dish_in_order ON Purchase.Purchase_id = Dish_in_order.Purchase_id
LEFT JOIN Menu ON Dish_in_order.Dish_id = Menu.Dish_id
WHERE Menu.Dish_name ='Grilled Salmon'
