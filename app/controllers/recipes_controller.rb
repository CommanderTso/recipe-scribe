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

  def edit
    @recipe = Recipe.find(params[:id])
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
