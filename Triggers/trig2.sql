CREATE TRIGGER dbo.trg_Dish_price_insert 
ON dbo.Menu
AFTER INSERT
AS
BEGIN
  DECLARE @Dish_id int
  DECLARE @Dish_price money
  SELECT @Dish_id = Dish_id, @Dish_price = Dish_price FROM inserted
  
  IF @Dish_price < 10 
  BEGIN
    RAISERROR ('Ниже 10', 16, 1)
    ROLLBACK TRANSACTION
  END
END; 