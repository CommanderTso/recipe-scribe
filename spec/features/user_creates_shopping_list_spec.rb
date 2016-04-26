require 'rails_helper'

feature "User creates a shopping list" do
  before(:each) do
    user = create(:user)
    login_user(user)

    bananas = create(:ingredient, name: "Bananas")
    whipped_cream = create(:ingredient, name: "Whipped Cream")
    pie_crust = create(:ingredient, name: "Pie Crust")

    bunches = create(:measurement_unit, name: "bunches")
    cans = create(:measurement_unit, name: "cans")
    package = create(:measurement_unit, name: "package")

    @recipe = user.recipes.new(title: "Banana Cream Pie", instructions: "Combine.")
    @recipe.recipe_ingredients.new(
      ingredient: bananas,
      measurement_unit: bunches,
      quantity: 2
    )
    @recipe.recipe_ingredients.new(
      ingredient: whipped_cream,
      measurement_unit: cans,
      quantity: 2
    )
    @recipe.recipe_ingredients.new(
      ingredient: pie_crust,
      measurement_unit: package,
      quantity: 2
    )
    @recipe.save
  end

  scenario "User adds a new ingredient", js: true do
    expect_no_page_reload do
      visit "/"


    end
  end
end
