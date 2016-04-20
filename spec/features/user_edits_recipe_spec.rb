require 'rails_helper'

# As a user, I want to edit my recipes.
#
# Acceptance Criteria:
# - Show page has an edit button
# - User can edit all fields and save to the database
# - Errors get raised if an edit would lead to an invalid record


feature "User edits a recipe" do
  before(:each) do
    @user = create(:user)
    login_user(@user)
    @recipe = create(:recipe_with_real_image, user: @user)
  end

  scenario "User makes valid edits to a recipe" do
    visit recipe_path(@recipe)

    click_link_or_button "Edit"

    expect(current_path).to eq(edit_recipe_path(@recipe.id))
    expect(find_field('Title').value).to eq @recipe.title
    expect(find_field('Instructions').value).to eq @recipe.instructions
    expect(page).to have_field "Recipe image"

    fill_in "Title", with: "New Title"
    fill_in "Instructions", with: "New instructions."
    attach_file "Recipe image", "spec/resources/burn-notice-bruce-campbell.jpg"

    click_button "Save"

    expect(page).to_not have_field "Title"
    expect(page).to_not have_field "Instructions"
    expect(page).to have_content "New Title"
    expect(page).to have_content "New instructions."
    expect(page).to have_xpath("//img[@alt='Burn notice bruce campbell']")
  end

  scenario "User makes invalid edits to a recipe" do
    visit recipe_path(@recipe)

    click_link_or_button "Edit"

    fill_in "Title", with: ""
    click_link_or_button "Save Recipe"

    expect(page).to have_content("Title can't be blank.")
    expect(find_field('Instructions').value).to have_content @recipe.instructions.slice(0, 10)
  end
end
