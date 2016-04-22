FactoryGirl.define do
  factory :recipe do
    title "My Old School Baked Ziti"
    instructions %(A few notes: To make this without meat, as I’m not
      personally into meat substitutes, I would use a pound or so of sliced
      mushrooms instead to make this vegetarian.)
    user
    # after(:build) { |recipe| recipe.recipe_ingredients << build(:recipe_ingredient) }
    # after(:build) do |recipe, _evaluator|
    #   create_list(:recipe_ingredient, 1, recipe: recipe)
    # end
    association :recipe_ingredient, factory: :recipe_ingredient
  end

  factory :ingredient do
    name "Potatoes"
    # initialize_with { Ingredient.find_or_create_by(name: name) }
  end

  factory :measurement_unit do
    name "lbs."
  end

  factory :recipe_ingredient do
    quantity 5
    association :measurement_unit, factory: :measurement_unit
    association :ingredient, factory: :ingredient
  end

  # factory :strawberry_vodka, class: Recipe do
  #   title "Strawberry Vodka"
  #   instructions "Eat some strawberries.  Wish this test had included vodka."
  #   user
  #   after(:build) { |recipe| recipe.recipe_ingredients << create(:pint_of_strawberries) }
  # end
  #
  # factory :ziti_potatoes_fake_image, parent: :ziti_with_potatoes do
  #   recipe_image Rack::Test::UploadedFile.new("spec/resources/test.txt")
  # end
  #
  # factory :ziti_potatoes_real_image, parent: :ziti_with_potatoes do
  #   recipe_image Rack::Test::UploadedFile.new("spec/resources/good_news.jpg")
  # end
end
