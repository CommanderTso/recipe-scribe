require 'rails_helper'

feature "User edits a recipe" do
  before(:each) do
    @user = create(:user)
    login_user(@user)

    @recipe_one = create(:recipe)
    @recipe_two = create(:recipe)
  end

  scenario "User makes valid edits to a recipe" do
    ingredient = @recipe_one.recipe_ingredients.first.ingredient.id.to_s
    measurement = @recipe_one.recipe_ingredients.first.measurement_unit.id.to_s
    quantity = @recipe_one.recipe_ingredients.first.quantity.to_s

    visit recipe_path(@recipe_one)

    click_link_or_button "Edit"

    expect(current_path).to eq(edit_recipe_path(@recipe_one.id))
    expect(find_field('Title').value).to eq @recipe_one.title
    expect(find_field('Instructions').value).to eq @recipe_one.instructions

    expect(page.find_field("recipe_recipe_ingredients_attributes_0_ingredient_id").value).to eq(ingredient)
    expect(page.find_field("recipe_recipe_ingredients_attributes_0_measurement_unit_id").value).to eq(measurement)
    expect(page.find_field("recipe_recipe_ingredients_attributes_0_quantity").value).to eq(quantity)

    expect(page).to have_field "Upload Recipe Image"

    fill_in "Title", with: "New Title"
    fill_in "Instructions", with: "New instructions."
    attach_file "Upload Recipe Image", "spec/resources/burn-notice-bruce-campbell.jpg"

    click_button "Save"

    expect(page).to_not have_field "Title"
    expect(page).to_not have_field "Instructions"
    expect(page).to have_content "New Title"
    expect(page).to have_content "New instructions."
    expect(page).to have_xpath("//img[@alt='Burn notice bruce campbell']")
  end

  scenario "User makes invalid edits to a recipe" do
    visit recipe_path(@recipe_one)

    click_link_or_button "Edit"

    fill_in "Title", with: ""
    click_link_or_button "Save Recipe"

    expect(page).to have_content("Title can't be blank.")
    expect(find_field('Instructions').value).to have_content @recipe_one.instructions.slice(0, 10)
  end
end
