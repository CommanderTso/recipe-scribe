FactoryGirl.define do
  factory :recipe do
    title "My Old School Baked Ziti"
    instructions %(A few notes: To make this without meat, as I’m not
      personally into meat substitutes, I would use a pound or so of sliced
      mushrooms instead to make this vegetarian.)
    user
  end

  factory :recipe_with_image, parent: :recipe do
    recipe_image Rack::Test::UploadedFile.new("spec/resources/test.txt")
  end

end
