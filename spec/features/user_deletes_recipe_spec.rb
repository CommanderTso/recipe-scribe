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
    @recipe = create(:recipe, user: @user)
  end

  scenario "User deletes a recipe" do
    visit recipe_path(@recipe)

    click_link_or_button "Delete"

    expect(current_path).to eq(recipes_path)
    expect(page).to have_content "Let's enter your first recipe!"
  end
end
