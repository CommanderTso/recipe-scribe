require 'rails_helper'

# As a user, I want to input recipes.
#
# **Acceptance Criteria:**
# - User can input a recipe with:
# -- a title (required)
# -- one or more ingredients (required)
# -- instructions (optional)
# - User is messaged if the entry succeeds
# - User is messaged with informative errors if the entry fails.

feature "User inputs a recipe" do
  scenario "User inputs a recipe" do
    title = "Title of a Recipe"
    instructions = "Instructions on how to make it!"

    visit root_path
    page.find('#add_recipe').click

    expect(page).to have_content "Add a new recipe here:"

    fill_in "Title", with: title
    fill_in "Instructions", with: instructions

    click_button "Add Recipe"

    expect(page).to have_content title
    expect(page).to have_content "Your recipe has been saved!"
  end

  scenario "User leaves out recipe title" do
    visit root_path
    page.find('#add_recipe').click

    click_button "Add Recipe"

    expect(page).to have_content "Add a new recipe here:"
    expect(page).to have_content "Title can't be blank"
  end
end
