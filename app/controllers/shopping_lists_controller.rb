class ShoppingListsController < ApplicationController
  def edit
    recipe_id = shopping_list_params["id"].split("-")[2]
    action = shopping_list_params["id"].split("-")[1]

    recipe = Recipe.find(recipe_id)
    update_list_items(recipe, action)
    update_recipe_increments(recipe, action)

    updated_list = []
    current_user.shopping_list.list_items.each do |item|
      updated_list << item.to_s
    end

    render json: { new_list: updated_list }
  end

  def update_list_items(recipe, action)
    recipe.recipe_ingredients.each do |recipe_ingredient|
      list_item = ListItem.find_or_create_by(
        shopping_list: current_user.shopping_list,
        ingredient: recipe_ingredient.ingredient,
        measurement_unit: recipe_ingredient.measurement_unit
      )

      list_item.update(action, recipe_ingredient.quantity)

      if list_item.quantity == 0
        list_item.destroy
      end
    end
  end

  def update_recipe_increments(recipe, action)
    recipe_increment = RecipeIncrement.find_or_create_by(
      shopping_list: current_user.shopping_list,
      recipe: recipe
    )
    recipe_increment.update(action)
  end

  def shopping_list_params
    params.permit(:id)
  end
end
