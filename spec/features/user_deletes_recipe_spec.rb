require 'rails_helper'

# As a user, I want to input recipes.
#
# Acceptance Criteria:
# - User can input a recipe with:
# -- a title (required)
# -- one or more ingredients (required)
# -- instructions (optional)
# - User is messaged if the entry succeeds
# - User is messaged with informative errors if the entry fails.
# - Recipes can be created with images attached
# - Images are displayed with the rest of the recipe info

feature "User deletes a recipe" do
  before(:each) do
    @user = create(:user)
    login_user(@user)
    @recipe = create(:recipe, user: @user)
  end

  scenario "User deletes a recipe" do
    visit recipe_path(@recipe)

    click_link_or_button "Delete"

    expect(current_path).to eq(recipes_path)
    expect(page).to have_content "Let's enter your first recipe!"
  end
end
