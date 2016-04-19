class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    
    if @recipe.save
      flash[:notice] = "Your recipe has been saved!"
      redirect_to root_path
    else
      flash.now[:error] = @recipe.errors.full_messages.join(", ")
      render :new
    end
  end

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :recipe_image)
  end
end
