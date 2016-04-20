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
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      flash[:notice] = "Your recipe has been saved!"
      redirect_to root_path
    else
      flash.now[:error] = @recipe.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    redirect_to recipes_path
  end

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :recipe_image)
  end
end
