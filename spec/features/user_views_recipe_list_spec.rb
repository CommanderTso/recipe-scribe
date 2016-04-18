require 'rails_helper'

# As a user, I want to view my recipes
#
# Done Criteria:
# - Viewing the index of recipes shows all recipes
# - All of a recipe's data is available on the page

feature "User inputs a recipe" do
  scenario "User views the recipe index" do
    recipe = create(:recipe)

    visit root_path

    expect(page).to have_content recipe.title
    expect(page).to have_content recipe.instructions
  end
end
