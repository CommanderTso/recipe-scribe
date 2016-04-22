FactoryGirl.define do
  factory :recipe_ingredient do
    quantity 5
    measurement_unit
    ingredient
    recipe
  end
end
