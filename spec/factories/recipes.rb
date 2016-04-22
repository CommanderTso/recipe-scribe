FactoryGirl.define do
  factory :recipe do
    sequence(:title) { |n| "Recipe Title #{n}" }
    sequence(:instructions) { |n| "Recipe instructions #{n}." }
    user

    before(:create) do |recipe|
      ri = build(:recipe_ingredient, recipe: recipe)
      recipe.recipe_ingredients << ri
    end

    factory :recipe_with_fake_image do
      recipe_image Rack::Test::UploadedFile.new("spec/resources/test.txt")
    end

    factory :recipe_with_real_image do
      recipe_image Rack::Test::UploadedFile.new("spec/resources/good_news.jpg")
    end
  end
end
