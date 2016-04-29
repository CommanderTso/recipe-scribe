class ShoppingList < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_increments
  has_many :list_items

  validates_presence_of :user

  def list_items
    super || []
  end

  def update_list_items(recipe, action)
    recipe.recipe_ingredients.each do |recipe_ingredient|
      list_item = ListItem.find_or_create_by(
        shopping_list: self,
        ingredient: recipe_ingredient.ingredient,
        measurement_unit: recipe_ingredient.measurement_unit
      )

      list_item.update_quantity(action, recipe_ingredient.quantity)

      if list_item.quantity == 0
        list_item.destroy
      end
    end
  end

  def update_recipe_increments(recipe, action)
    recipe_increment = RecipeIncrement.find_or_create_by(
      shopping_list: self,
      recipe: recipe
    )

    recipe_increment.update_quantity(action)
  end

end
