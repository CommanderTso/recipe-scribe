user_1 = User.find_by(email: "abc@abc.com")
unless user_1.present?
  user_1 = User.create(
    name: "Sharky Fitzgerald",
    email: "abc@abc.com",
    password: "123123123",
    password_confirmation: "123123123"
  )
end

Recipe.find_or_create_by(
  user: user_1,
  title: "My Old School Baked Ziti",
  instructions: %(A few notes: To make this without meat, as I’m not personally
    into meat substitutes, I would use a pound or so of sliced mushrooms instead
    to make this vegetarian. To freeze, you can freeze this unbaked and once
    defrosted, bake it in the oven as directed. You could also freeze it after
    baking, and just defrost and rewarm it, but that leads to softer noodles
    because they get warmed/cooked an extra time. Finally, if you really really
    like those crispy edges (I do!), I find if you use a round or oval dish and
    ziti noodles (with straight ends) vs. penne noodles (which usually have
    angled ends), it especially leaves jagged edges, more prone to crisping. It
    also helps to just pour the pasta mix into the dish, not press it into the
    corners.

    Glug of olive oil
    1 medium onion, chopped small
    2 garlic cloves, minced
    1 pound ground beef or Italian sausage, casings removed
    28-ounce can whole tomatoes with juices, chopped by you, or crushed tomatoes
    1 teaspoon dried oregano
    Red pepper flakes, to taste
    1 pound pasta, cooked al dente and drained
    3/4 pound mozzarella, coarsely grated
    2/3 cup finely grated pecorino or parmesan cheese
    1/4 pound (4 ounces) baby spinach or a few handfuls of another green, cut into thin ribbons
    To serve: Dollops of your favorite ricotta and slivers of basil leaves, if desired

    Heat oven to 400 degrees F.

    Cook pasta until quite al dente, or 2 minutes less than the suggested cooking
     time. (Please. It will keep cooking in the sauce, then in the oven and mushy
     pasta makes me sad.) Reserve 1/2 cup cooking water, then drain pasta.

    Heat large sauté pan — if yours is ovenproof, you can even use it as you final
    baking vessel — over medium heat. Coat with glug of olive oil, and heat oil.
    Add meat and cook with onion, garlic, oregano, pepper flakes, and salt over
    medium-high heat for 6 to 8 minutes or until meat is browned; stirring
    frequently. If you’re using plain ground beef versus sausage meat, you’re
    going to really want to season this well. Don’t be shy with the salt and pepper.

    Add crushed tomatoes and stir to combine. Reduce heat to medium-low and
    simmer for 5 minutes. Adjust seasonings to taste. If it’s become quite
    thick, stir in reserved pasta water. Add spinach and cook until wilted,
    just another minute. Stir in drained pasta and heat together for one minute.

    Pour half of pasta mixture into a 9×13-inch baking dish, lasagna pan, or
    other 3-quart baking vessel (or divide among smaller ones, if you’d like
    to freeze some off). Sprinkle with half of each cheese. Pour remaining pasta
    and sauce over, and finish with remaining cheese. Bake in heated oven for
    30 minutes.

    If you wish, you can run the dish under your broiler for a minute or two
    for an extra-bronzed lid right before serving.)
)
