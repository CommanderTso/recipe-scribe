require 'rails_helper'

feature "User edits a recipe" do
  before(:each) do
    @user = create(:user)
    login_user(@user)

    strawberries = create(:ingredient_strawberries)
    create(:ingredient_potatoes)
    create(:three_pints_strawberries, ingredient: strawberries)
    # @recipe = create(:ziti_strawberries_real_image, user: @user)
  end

  scenario "User makes valid edits to a recipe" do
    visit recipe_path(@recipe)

    click_link_or_button "Edit"

    save_and_open_page
    expect(current_path).to eq(edit_recipe_path(@recipe.id))
    expect(find_field('Title').value).to eq @recipe.title
    expect(find_field('Instructions').value).to eq @recipe.instructions
    expect(page.find('//select[@id="recipe_recipe_ingredients_attributes_0_ingredient"]').text).to eq("Strawberries")
    expect(page.find('//select[@id="recipe_recipe_ingredients_attributes_0_measurement_unit"]').text).to eq("lbs.")
    expect(page.find('//input[@id="recipe_recipe_ingredients_attributes_0_quantity"]').value).to eq("5")

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
