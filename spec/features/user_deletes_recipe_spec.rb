require 'rails_helper'

# As a user, I want to delete my recipes.
#
# Acceptance Criteria:
# - Show page has a delete button
# - Deleting a recipe cascades to other necessary records

feature "User deletes a recipe" do
  before(:each) do
    @user = create(:user)
    login_user(@user)
    # @recipe = create(:ziti_with_potatoes, user: @user)

    potatoes = Ingredient.create(name: "Potatoes")
    lbs = MeasurementUnit.create(name: "lbs")

    @recipe = Recipe.new(
      title: "A title",
      instructions: "Some instructions.",
      user: @user
    )

    @recipe.recipe_ingredients.new(
      quantity: 2,
      measurement_unit: lbs,
      ingredient: potatoes
    )

    @recipe.save
  end

  scenario "User deletes a recipe" do
    visit recipe_path(@recipe)

    click_link_or_button "Delete"

    expect(current_path).to eq(recipes_path)
    expect(page).to have_content "Let's enter your first recipe!"
  end

  xscenario "Need test for cascading deletion of related recipe records", js: true do
    visit root_path
    click_link "list-add-#{@recipe.id}"

    expect(page.find("#shopping_list")).to have_content("2 lbs of Potatoes")

    visit recipe_path(@recipe)
    click_link_or_button "Delete"

    expect(current_path).to eq(recipes_path)
    expect(page).to have_content "Let's enter your first recipe!"

    expect(RecipeIngredient.all.count).to eq(0)
    expect(@user.shopping_list.recipe_increments.count).to eq(0)
    expect(@user.shopping_list.list_items.count).to eq(0)
  end
end
