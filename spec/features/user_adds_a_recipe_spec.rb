require 'rails_helper'

# Ingredients
#
# - Need two possible per recipe
# - At least one is required
# - Breaks out into ingredient, measurement, and quantity

feature "User inputs a recipe" do
  before(:each) do
    create(:strawberries, name: "Potatoes")
    create(:strawberries, name: "Saffron")
    create(:pints, name: "lbs.")
    create(:pints, name: "oz.")

    @title = "Title of a Recipe"
    @instructions = "Instructions on how to make it!"


    login_user(create(:user))
  end

  scenario "User inputs a recipe" do
    visit root_path
    page.find('#add_recipe').click

    expect(page).to have_content "Add a new recipe here:"

    fill_in "Title", with: @title
    fill_in "Instructions", with: @instructions

    select('Potatoes', :from => 'recipe_recipe_ingredients_attributes_0_ingredient')
    select('lbs.', :from => 'recipe_recipe_ingredients_attributes_0_measurement_unit')
    fill_in "recipe_recipe_ingredients_attributes_0_quantity", with: "3"

    select('Saffron', :from => 'recipe_recipe_ingredients_attributes_1_ingredient')
    select('oz.', :from => 'recipe_recipe_ingredients_attributes_1_measurement_unit')
    fill_in "recipe_recipe_ingredients_attributes_1_quantity", with: "20"

    click_button "Save Recipe"

    expect(Recipe.count).to eq 1
    expect(RecipeIngredient.count).to eq 2
    expect(page).to have_content @title
    expect(page).to have_content "Your recipe has been saved!"
  end

  scenario "User leaves out recipe title" do
    visit root_path
    page.find('#add_recipe').click

    click_button "Save Recipe"

    expect(Recipe.count).to eq 0
    expect(page).to have_content "Add a new recipe here:"
    expect(page).to have_content "Title can't be blank"
  end

  scenario "User has an ingredient, but leaves a second ingredient input blank" do
    visit root_path
    page.find('#add_recipe').click

    expect(page).to have_content "Add a new recipe here:"

    fill_in "Title", with: @title
    fill_in "Instructions", with: @instructions

    select('Potatoes', :from => 'recipe_recipe_ingredients_attributes_0_ingredient')
    select('lbs.', :from => 'recipe_recipe_ingredients_attributes_0_measurement_unit')
    fill_in "recipe_recipe_ingredients_attributes_0_quantity", with: "3"

    click_button "Save Recipe"

    expect(Recipe.count).to eq 1
    expect(RecipeIngredient.count).to eq 1
    expect(Recipe.first.recipe_ingredients.count).to eq 1
    expect(page).to have_content @title
    expect(page).to have_content "Your recipe has been saved!"
  end
end
