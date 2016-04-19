require 'rails_helper'

# As a user, I want to log in so I can see and edit my recipes
#
# Acceptance Criteria:
# - user can create an account
# - user can log into their account
# - user can only see, edit, and delete recipes that belong to them

feature "User tries the site without being logged in" do
  scenario "User goes to root" do
    visit root_path
    expect(page).to have_current_path login_path
  end

  scenario "User goes to recipes#index" do
    visit recipes_path
    expect(page).to have_current_path login_path
  end

  scenario "User goes to recipes#new" do
    visit new_recipe_path
    expect(page).to have_current_path login_path
  end
end

feature "User logs into an account" do
  scenario "User logs into an account" do
    user = create(:user)
    recipe = create(:recipe, user: user)

    visit root_path

    expect(page).to_not have_content recipe.title
    expect(page).to_not have_content recipe.instructions

    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Submit"

    expect(page).to have_content recipe.title
    expect(page).to have_content recipe.instructions
    expect(page).to have_content "Signed in as #{user.name}"
  end
end

feature "User creates an account" do
  scenario "User creates an account" do
    name = "Francine"
    email = "francine@ghostbusters.com"
    password = "123123123"
    password_confirm = "123123123"
    recipe = create(:recipe)

    visit signup_path

    fill_in "user[email]", with: email
    fill_in "user[name]", with: name
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: password_confirm
    click_button "Submit"

    expect(page).to_not have_content recipe.title
    expect(page).to_not have_content recipe.instructions
    expect(page).to have_content "Signed in as #{name}"
  end
end
