require 'rails_helper'

# As a user, I want to see my whole recipe on a separate page
#
# # Done Criteria:
# - clicking a link in the index takes you to the show page
# - show page has the title, description, and photo for the recipe

feature "User views a recipe show page" do
  scenario "User views the recipe show page" do
    user = create(:user)
    login_user(user)
    recipe = create(:recipe_with_real_image, user: user)

    visit root_path

    page.find("//a[@id='recipe-link-#{recipe.id}']").click

    expect(page).to have_content recipe.title
    expect(page).to have_content recipe.instructions
    expect(page).to have_selector("img[src='#{recipe.image_url}']")
  end
end
