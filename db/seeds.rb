potatoes = Ingredient.find_or_create_by!(name: "Potatoes")
bread = Ingredient.find_or_create_by!(name: "Bread")
strawberries =Ingredient.find_or_create_by!(name: "Strawberries")

lbs = MeasurementUnit.find_or_create_by!(name: "lbs.")
loaves = MeasurementUnit.find_or_create_by!(name: "loaves")
pints = MeasurementUnit.find_or_create_by!(name: "pints")

five_lbs_potatoes = RecipeIngredient.find_or_create_by!(
  ingredient: potatoes,
  measurement_unit: lbs,
  quantity: 5
)

three_loaves_bread = RecipeIngredient.find_or_create_by!(
  ingredient: bread,
  measurement_unit: loaves,
  quantity: 3
)

one_pint_strawberries = RecipeIngredient.find_or_create_by!(
  ingredient: strawberries,
  measurement_unit: pints,
  quantity: 1
)

user_1 = User.find_by(email: "abc@abc.com")
unless user_1.present?
  user_1 = User.create!(
    name: "Sharky Fitzgerald",
    email: "abc@abc.com",
    password: "123123123",
    password_confirmation: "123123123"
  )
end

recipe_1 = Recipe.find_by(title: "Potato Surprise")
unless recipe_1.present?
  Recipe.create!(
    user: user_1,
    recipe_ingredients: [five_lbs_potatoes],
    title: "Potato Surprise",
    instructions: %(Surprise!  It's 5 lbs of poatoes.  Have fun.)
  )
end

recipe_2 = Recipe.find_by(title: "Potato Bread")
unless recipe_2.present?
  Recipe.create!(
    user: user_1,
    recipe_ingredients: [five_lbs_potatoes, three_loaves_bread],
    title: "Potato Bread",
    instructions: %(Here are some bread and potatoes.)
  )
end

recipe_3 = Recipe.find_by(title: "Strawberry Bread")
unless recipe_3.present?
  Recipe.create!(
    user: user_1,
    recipe_ingredients: [one_pint_strawberries, three_loaves_bread],
    title: "Strawberry Bread",
    instructions: %(This is a terrbile idea.)
  )
end
