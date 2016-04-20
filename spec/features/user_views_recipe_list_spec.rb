require 'rails_helper'

# As a user, I want to view my recipes
#
# Done Criteria:
# - Viewing the index of recipes shows all recipes
# - All of a recipe's data is available on the page

feature "User views their recipes" do
  scenario "User views the recipe index" do
    user = create(:user)
    login_user(user)
    recipe = create(:recipe, user: user)

    visit root_path

    expect(page).to have_content recipe.title
  end

  scenario "User sees only recipes that belong to them" do
    user_1 = create(:user, email: "scott@mac.com")
    recipe_1 = create(:recipe, user: user_1, title: "My title")

    user_2 = create(:user, email: "edna@cats.com")
    recipe_2 = create(:recipe, user: user_2, title: "Different Title")

    login_user(user_1)

    visit root_path

    expect(page).to have_content recipe_1.title
    expect(page).to_not have_content recipe_2.title
  end
end
