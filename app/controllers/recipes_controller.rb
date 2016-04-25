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
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:notice] = "Recipe updated!"
      redirect_to recipe_path(@recipe)
    else
      flash[:error] = get_errors(@recipe)
      render :edit
    end
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      flash[:notice] = "Your recipe has been saved!"
      redirect_to root_path
    else
      flash.now[:error] = get_errors(@recipe)

      if @recipe.recipe_ingredients.length < 2
        number_to_build = 2
      else
        number_to_build = @recipe.recipe_ingredients.length
      end
      number_to_build.times { @recipe.recipe_ingredients.build }

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
    params.require(
      :recipe
    ).permit(
      :title,
      :instructions,
      :recipe_image,
      recipe_ingredients_attributes: [:id, :quantity, :measurement_unit_id, :ingredient_id]
    )
  end
end
