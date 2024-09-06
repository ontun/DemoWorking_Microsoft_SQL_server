CREATE FUNCTION GetTotalOrderSum (@institution_id int)
RETURNS MONEY
AS
BEGIN
    DECLARE @total_sum MONEY
    SET @total_sum = 0
    
    SELECT @total_sum = @total_sum + (Dish_price*Dish_quantity)
    FROM Dish_in_order
    INNER JOIN Menu ON Dish_in_order.Dish_id = Menu.Dish_id
    INNER JOIN Purchase ON Dish_in_order.Purchase_id = Purchase.Purchase_id
    WHERE Purchase.Institution_id = @institution_id
    
    RETURN @total_sum
END