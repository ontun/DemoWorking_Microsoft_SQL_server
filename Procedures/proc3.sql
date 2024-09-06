CREATE PROCEDURE AddIngredient
(
    @Ingredient_name char(25),
    @Ingredient_quantity int,
    @Ingredient_price money,
    @Ingredient_time int,
    @Ingredient_del char(25),
    @Ingredient_measurement char(18)
)
AS
BEGIN
	DECLARE @Ing_id int
	SET @Ing_id = (SELECT MAX(Ingredient_id) FROM Ingredient)+1
    INSERT INTO Ingredient (Ingredient_id,Ingredient_name, Ingredient_quantity, Ingredient_price, Ingredient_time, Ingredient_del, Ingredient_measurement)
    VALUES (@Ing_id,@Ingredient_name, @Ingredient_quantity, @Ingredient_price, @Ingredient_time, @Ingredient_del, @Ingredient_measurement)
END