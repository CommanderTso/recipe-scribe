require 'rails_helper'

feature "User creates a shopping list" do
  before(:each) do
    user = create(:user)
    login_user(user)

    bananas = create(:ingredient, name: "bananas")
    whipped_cream = create(:ingredient, name: "whipped cream")
    pie_crust = create(:ingredient, name: "pie crusts")

    bunches = create(:measurement_unit, name: "bunches")
    cans = create(:measurement_unit, name: "cans")
    package = create(:measurement_unit, name: "packages")

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

  scenario "User adds then removes a new ingredient", js: true do
    visit "/"

    expect(page.find("#list-buying-total-#{@recipe.id}")).to have_content(0)
    expect(page.find("#shopping_list")).to have_content("Empty list!")

    click_link "list-add-#{@recipe.id}"

    # expect empty message when starting
    expect(page.find("#shopping_list")).to have_content("2 bunches of bananas")
    expect(page.find("#shopping_list")).to have_content("2 cans of whipped cream")
    expect(page.find("#shopping_list")).to have_content("2 packages of pie crusts")
    expect(page.find("#list-buying-total-#{@recipe.id}")).to have_content(1)

    click_link "list-remove-#{@recipe.id}"

    expect(page.find("#shopping_list")).to have_content("Empty list!")
    expect(page.find("#list-buying-total-#{@recipe.id}")).to have_content(0)
  end

  scenario "User refreshes page with a populated shopping list", js: true do
    visit "/"

    click_link "list-add-#{@recipe.id}"
    click_link "list-add-#{@recipe.id}"

    expect(page.find("#shopping_list")).to have_content("4 bunches of bananas")
    expect(page.find("#shopping_list")).to have_content("4 cans of whipped cream")
    expect(page.find("#shopping_list")).to have_content("4 packages of pie crusts")
    expect(page.find("#list-buying-total-#{@recipe.id}")).to have_content(2)

    visit "/"

    expect(page.find("#shopping_list")).to have_content("4 bunches of bananas")
    expect(page.find("#shopping_list")).to have_content("4 cans of whipped cream")
    expect(page.find("#shopping_list")).to have_content("4 packages of pie crusts")
    expect(page.find("#list-buying-total-#{@recipe.id}")).to have_content(2)
  end

  scenario "Reducing a recipe's increment below zero does nothing", js: true do
    visit "/"

    click_link "list-add-#{@recipe.id}"

    expect(page.find("#shopping_list")).to have_content("2 bunches of bananas")
    expect(page.find("#shopping_list")).to have_content("2 cans of whipped cream")
    expect(page.find("#shopping_list")).to have_content("2 packages of pie crusts")
    expect(page.find("#list-buying-total-#{@recipe.id}")).to have_content(1)

    click_link "list-add-#{@recipe.id}"

    expect(page.find("#shopping_list")).to have_content("4 bunches of bananas")
    expect(page.find("#shopping_list")).to have_content("4 cans of whipped cream")
    expect(page.find("#shopping_list")).to have_content("4 packages of pie crusts")
    expect(page.find("#list-buying-total-#{@recipe.id}")).to have_content(2)
  end
end
