Ingredient.find_or_create_by!(name: "Potatoes")
Ingredient.find_or_create_by!(name: "Bread")
Ingredient.find_or_create_by!(name: "Strawberries")

MeasurementUnit.find_or_create_by!(name: "lbs.")
MeasurementUnit.find_or_create_by!(name: "loaves")
MeasurementUnit.find_or_create_by!(name: "pints")

RecipeIngredient.find_or_create_by!(
  ingredient: Ingredient.first,
  measurement_unit: MeasurementUnit.first,
  quantity: 5
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

recipe_1 = Recipe.find_by(title: "My Old School Baked Ziti")
unless recipe_1.present?
  Recipe.create!(
    user: user_1,
    recipe_ingredients: [RecipeIngredient.first],
    title: "My Old School Baked Ziti",
    instructions: %(A few notes: To make this without meat, as I’m not personally
      into meat substitutes, I would use a pound or so of sliced mushrooms instead
      to make this vegetarian. To freeze, you can freeze this unbaked and once
      defrosted, bake it in the oven as directed. You could also freeze it after
      baking, and just defrost and rewarm it, but that leads to softer noodles
      because they get warmed/cooked an extra time. Finally, if you really really
      like those crispy edges (I do!), I find if you use a round or oval dish and
      ziti noodles (with straight ends) vs. penne noodles (which usually have
      angled ends), it especially leaves jagged edges, more prone to crisping. It
      also helps to just pour the pasta mix into the dish, not press it into the
      corners.)
  )
end
