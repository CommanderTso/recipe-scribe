feature "User adds an image to recipe" do
  before(:each) do
    StorageBucket.files.each do |file|
      file.destroy
    end

    @user = create(:user)
    login_user(@user)
  end

  scenario "Display recipe images in a recipe" do
    recipe = create(:recipe_with_fake_image, user: @user)

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
      click_button "Save Recipe"
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
      click_button "Save Recipe"
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

  scenario "Editing a recipe's image" do
    recipe = create(:recipe_with_fake_image, user: @user)

    visit root_path
    click_link "recipe-link-#{recipe.id}"
    click_link "Edit"
    attach_file "Recipe image", "spec/resources/test_2.txt"
    click_button "Save Recipe"

    expect(page).to have_content "Recipe updated!"
    expect(StorageBucket.files.get("recipe_images/#{recipe.id}/test_2.txt")).to be_present
    expect(StorageBucket.files.get("recipe_images/#{recipe.id}/test.txt")).to be_nil

    recipe.reload
    expect(recipe.image_url).to end_with "/recipe_images/#{recipe.id}/test_2.txt"
  end

  scenario "Deleting a recipe with an image" do
    recipe = create(:recipe_with_fake_image, user: @user)

    image_key = "recipe_images/#{recipe.id}/test.txt"
    expect(StorageBucket.files.get(image_key)).to be_present

    visit root_path
    click_link recipe.title
    click_link "recipe-link-#{recipe.id}"
    click_link_or_button "Delete"

    expect(Recipe.exists?(recipe.id)).to be false
    expect(StorageBucket.files.get(image_key)).to be_nil
  end
end