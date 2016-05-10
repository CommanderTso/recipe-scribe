Ingredient.find_or_create_by!(name: "Potatoes")
Ingredient.find_or_create_by!(name: "Strawberries")
Ingredient.find_or_create_by!(name: "Proscuttio")
Ingredient.find_or_create_by!(name: "Milk")
Ingredient.find_or_create_by!(name: "Salt")
bread = Ingredient.find_or_create_by!(name: "Bread")
onion = Ingredient.find_or_create_by!(name: "Onion")
beef85 = Ingredient.find_or_create_by!(name: "85% Beef")
chopped_tomatoes = Ingredient.find_or_create_by!(name: "Chopped Tomatoes")
kidney_beans = Ingredient.find_or_create_by!(name: "Kidney Beans")
cheese = Ingredient.find_or_create_by!(name: "Cheese")
butter = Ingredient.find_or_create_by!(name: "Butter")
italian_sausage = Ingredient.find_or_create_by!(name: "Italian Sausage")
ziti = Ingredient.find_or_create_by!(name: "Ziti")
asparagus = Ingredient.find_or_create_by!(name: "Asparagus")
eggs = Ingredient.find_or_create_by!(name: "Eggs")
scallions = Ingredient.find_or_create_by!(name: "Scallions")
goat_cheese = Ingredient.find_or_create_by!(name: "Goat Cheese")

lbs = MeasurementUnit.find_or_create_by!(name: "lbs.")
loaves = MeasurementUnit.find_or_create_by!(name: "loaves")
MeasurementUnit.find_or_create_by!(name: "pints")
large = MeasurementUnit.find_or_create_by!(name: "large")
MeasurementUnit.find_or_create_by!(name: "tbsps")
MeasurementUnit.find_or_create_by!(name: "pints")
MeasurementUnit.find_or_create_by!(name: "tsps")
bunch = MeasurementUnit.find_or_create_by!(name: "bunch")
can = MeasurementUnit.find_or_create_by!(name: "can")
stick = MeasurementUnit.find_or_create_by!(name: "stick")
dozen = MeasurementUnit.find_or_create_by!(name: "dozen")
ozs = MeasurementUnit.find_or_create_by!(name: "ozs")

user_1 = User.find_by(email: "abc@abc.com")
unless user_1.present?
  user_1 = User.create!(
    name: "Sharky Fitzgerald",
    email: "abc@abc.com",
    password: "123123123",
    password_confirmation: "123123123"
  )
end

recipe_1 = Recipe.find_by(title: "Chilli Con Carne")
unless recipe_1.present?
  one_large_onion = RecipeIngredient.create!(
    ingredient: onion,
    measurement_unit: large,
    quantity: 1
  )

  one_lb_85_beef = RecipeIngredient.create!(
    ingredient: beef85,
    measurement_unit: lbs,
    quantity: 1
  )

  one_can_chopped_tomatoes = RecipeIngredient.create!(
    ingredient: chopped_tomatoes,
    measurement_unit: can,
    quantity: 1
  )

  one_can_kidney_beans = RecipeIngredient.create!(
    ingredient: kidney_beans,
    measurement_unit: can,
    quantity: 1
  )

  Recipe.create!(
    user: user_1,
    recipe_ingredients: [
      one_large_onion,
      one_lb_85_beef,
      one_can_chopped_tomatoes,
      one_can_kidney_beans
    ],
    title: "Chilli Con Carne"
  )
end

recipe_2 = Recipe.find_by(title: "Grilled Cheese")
unless recipe_2.present?
  one_lb_cheese = RecipeIngredient.create!(
    ingredient: cheese,
    measurement_unit: lbs,
    quantity: 1
  )

  one_loaf_bread = RecipeIngredient.create!(
    ingredient: bread,
    measurement_unit: loaves,
    quantity: 1
  )

  one_stick_butter = RecipeIngredient.create!(
    ingredient: butter,
    measurement_unit: stick,
    quantity: 1
  )

  Recipe.create!(
    user: user_1,
    recipe_ingredients: [
      one_lb_cheese,
      one_loaf_bread,
      one_stick_butter
    ],
    title: "Grilled Cheese"
  )
end

recipe_3 = Recipe.find_by(title: "Mom's Baked Ziti")
unless recipe_3.present?
  one_large_onion = RecipeIngredient.create!(
    ingredient: onion,
    measurement_unit: large,
    quantity: 1
  )

  one_lb_italian_sausage = RecipeIngredient.create!(
    ingredient: italian_sausage,
    measurement_unit: lbs,
    quantity: 1
  )

  one_can_chopped_tomatoes = RecipeIngredient.create!(
    ingredient: chopped_tomatoes,
    measurement_unit: can,
    quantity: 1
  )

  one_lbs_ziti = RecipeIngredient.create!(
    ingredient: ziti,
    measurement_unit: lbs,
    quantity: 1
  )

  Recipe.create!(
    user: user_1,
    recipe_ingredients: [
      one_large_onion,
      one_lb_italian_sausage,
      one_can_chopped_tomatoes,
      one_lbs_ziti
    ],
    title: "Mom's Baked Ziti"
  )
end

recipe_4 = Recipe.find_by(title: "Asparagus Frittata")
unless recipe_4.present?
  half_lb_asparagus = RecipeIngredient.create!(
    ingredient: asparagus,
    measurement_unit: lbs,
    quantity: 1
  )

  one_dozen_eggs = RecipeIngredient.create!(
    ingredient: eggs,
    measurement_unit: dozen,
    quantity: 1
  )

  one_bunch_scallions = RecipeIngredient.create!(
    ingredient: scallions,
    measurement_unit: bunch,
    quantity: 1
  )

  eight_oz_goat_cheese = RecipeIngredient.create!(
    ingredient: goat_cheese,
    measurement_unit: ozs,
    quantity: 1
  )

  Recipe.create!(
    user: user_1,
    recipe_ingredients: [
      half_lb_asparagus,
      one_dozen_eggs,
      one_bunch_scallions,
      eight_oz_goat_cheese
    ],
    title: "Asparagus Frittata"
  )
end
