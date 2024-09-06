SELECT Ingredient.Ingredient_name
FROM Ingredient
JOIN Ingredients_in_dish ON Ingredient.Ingredient_id = Ingredients_in_dish.Ingredient_id
JOIN Menu ON Ingredients_in_dish.Dish_id = Menu.Dish_id
WHERE Menu.Dish_name = 'Cheeseburger'