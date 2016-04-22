# FactoryGirl.define do
#
#
#   factory :pint_of_strawberries, class: RecipeIngredient do
#     strawberries
#     pints
#     quantity 1
#     recipe
#   end
# end

# User model that belongs to a Group
# RecipeIngredient model that belongs to a Recipe
#
# FactoryGirl.define do
#   factory :recipe do
#     name "name"
#     initialize_with { Group.find_or_create_by_name(name)}
#   end
#
#   factory :recipe_ingredient do
#     association :recipe
#   end
# end
