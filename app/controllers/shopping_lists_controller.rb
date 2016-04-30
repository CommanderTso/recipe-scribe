class ShoppingListsController < ApplicationController
  def edit
    recipe_id = shopping_list_params["id"].split("-")[2]
    action = shopping_list_params["id"].split("-")[1]

    shopping_list = current_user.shopping_list
    recipe = Recipe.find(recipe_id)

    shopping_list.update_list_items(recipe, action)
    shopping_list.update_recipe_increments(recipe, action)

    updated_list = []
    current_user.shopping_list.list_items.each do |item|
      updated_list << item.to_s
    end

    render json: { new_list: updated_list }
  end

  def shopping_list_params
    params.permit(:id)
  end
end
