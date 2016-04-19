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

feature "User inputs a recipe" do
  before(:each) do
    login_user(create(:user))
  end

  scenario "User inputs a recipe" do
    title = "Title of a Recipe"
    instructions = "Instructions on how to make it!"

    visit root_path
    page.find('#add_recipe').click

    expect(page).to have_content "Add a new recipe here:"

    fill_in "Title", with: title
    fill_in "Instructions", with: instructions

    click_button "Add Recipe"

    expect(Recipe.count).to eq 1
    expect(page).to have_content title
    expect(page).to have_content "Your recipe has been saved!"
  end

  scenario "User leaves out recipe title" do
    visit root_path
    page.find('#add_recipe').click

    click_button "Add Recipe"

    expect(Recipe.count).to eq 0
    expect(page).to have_content "Add a new recipe here:"
    expect(page).to have_content "Title can't be blank"
  end
end

feature "with Recipe Images" do
  before(:each) do
    StorageBucket.files.each do |file|
      file.destroy
    end

    login_user(create(:user))
  end

  scenario "Display recipe images in a recipe" do
    recipe = create(:recipe_with_image)

    visit root_path

    expect(page).to have_content recipe.title
    expect(page).to have_css "img[src='#{recipe.image_url}']"
  end

  scenario "Adding a recipe with an image" do
    visit root_path
    page.find('#add_recipe').click

    expect(page).to have_content "Add a new recipe here:"

    within "form.new_recipe" do
      fill_in "Title", with: "A Tale of Two Bagels"
      attach_file "Recipe image", "spec/resources/test.txt"
      click_button "Add Recipe"
    end

    expect(page).to have_content "Your recipe has been saved!"
    expect(Recipe.count).to eq 1

    recipe = Recipe.first
    expect(recipe.title).to eq "A Tale of Two Bagels"
    expect(recipe.image_url).to end_with "/recipe_images/#{recipe.id}/test.txt"

    expect(StorageBucket.files.all.count).to eq 1
    file = StorageBucket.files.first
    expect(file.key).to eq "recipe_images/#{recipe.id}/test.txt"
    expect(file.body).to include "A test file."
  end

  scenario "Recipe image has a space in its file name" do
    visit  new_recipe_path

    within "form.new_recipe" do
      fill_in "Title", with: "A Tale of Two Bagels"
      attach_file "Recipe image", "spec/resources/test file three.txt"
      click_button "Add Recipe"
    end

    expect(page).to have_content "Your recipe has been saved!"
    expect(Recipe.count).to eq 1

    recipe = Recipe.first
    expect(recipe.title).to eq "A Tale of Two Bagels"
    expect(recipe.image_url).to end_with "/recipe_images/#{recipe.id}/test_file_three.txt"

    expect(StorageBucket.files.all.count).to eq 1
    file = StorageBucket.files.first
    expect(file.key).to eq "recipe_images/#{recipe.id}/test_file_three.txt"
    expect(file.body).to include "A third test file!"
  end

  xscenario "Editing a recipe's image" do
    recipe = create(:recipe_with_image)

    visit root_path
    click_link recipe.title
    click_link "Edit Recipe"
    attach_file "Recipe image", "spec/resources/test-2.txt"
    click_button "Save"

    expect(page).to have_content "Updated Recipe"
    expect(StorageBucket.files.get("recipe_images/#{recipe.id}/test-2.txt")).to be_present
    expect(StorageBucket.files.get("recipe_images/#{recipe.id}/test.txt")).to be_nil

    recipe.reload
    expect(recipe.image_url).to end_with "/recipe_images/#{recipe.id}/test-2.txt"
  end

  xscenario "Deleting a recipe with an image" do
    recipe = create(:recipe_with_image)

    image_key = "recipe_images/#{recipe.id}/test.txt"
    expect(StorageBucket.files.get(image_key)).to be_present

    visit root_path
    click_link recipe.title
    click_link "Delete Recipe"

    expect(Recipe.exists?(recipe.id)).to be false
    expect(StorageBucket.files.get(image_key)).to be_nil
  end
end
