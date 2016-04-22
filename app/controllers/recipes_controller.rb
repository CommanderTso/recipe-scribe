class RecipesController < ApplicationController
  before_filter :authorize

  def index
    @recipes = Recipe.where(user: current_user)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    2.times { @recipe.recipe_ingredients.build }
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_ingredients = @recipe.recipe_ingredients
    unless current_user == @recipe.user
      flash[:error] = "You are not authorized to edit this recipe!"
      redirect_to root_path
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:notice] = "Recipe updated!"
      redirect_to recipe_path(@recipe)
    else
      # TODO - This is a big, hairy hack to get around my other hack
      # of saving RecipeIngredients before we know if Recipe is validates
      @recipe.recipe_ingredients.delete_all
      flash[:error] = get_errors(@recipe)
      render :edit
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      flash[:notice] = "Your recipe has been saved!"
      redirect_to root_path
    else
      flash.now[:error] = get_errors(@recipe)
      2.times { @recipe.recipe_ingredients.build }
      render :new
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    redirect_to recipes_path
  end

  def recipe_ingredients_from_params
    ingredients = []
    params["recipe"]["recipe_ingredients_attributes"].values.each do |attributes|
      ingredient = Ingredient.find(attributes[:ingredient])
      measurement_unit = MeasurementUnit.find(attributes[:measurement_unit])
      quantity = attributes[:quantity]
      recipe_ingredient = RecipeIngredient.create(
        ingredient: ingredient,
        measurement_unit: measurement_unit,
        quantity: quantity
      )
      ingredients << recipe_ingredient.id
    end

    ingredients
  end

  def recipe_params
    # TODO - This here is a hack to deal with the fact that the form
    # passes back IDs of already-made RecipeIngredient components
    # I couln't find a better way to deal with things than to
    # create the RecipeIngredient separately, then pass the id's
    # with the recipe_params.
    #
    # Up above, we delete the created records if the Recipe fails to eliminate
    # orphan records
    ingredients = recipe_ingredients_from_params
    params[:recipe][:recipe_ingredient_ids] = ingredients

    params.require(
      :recipe
    ).permit(
      :title,
      :instructions,
      :recipe_image,
      recipe_ingredient_ids: []
    )
  end
end
