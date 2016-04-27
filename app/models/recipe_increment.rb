class RecipeIncrement < ActiveRecord::Base
  belongs_to :shopping_list
  belongs_to :recipe

  validates_presence_of :shopping_list, :recipe

  def update(direction)
    if direction == "add"
      self.quantity += 1
    else
      self.quantity -= 1
    end

    if self.quantity < 0 then self.quantity = 0 end

    self.save
  end

  def self.all_for_shopping_list(shopping_list)
    collection = {}
    if !shopping_list.recipe_increments.empty?
      shopping_list.recipe_increments.each do |increment|
        collection[increment.recipe.id] = increment.quantity
      end
    end
    collection
  end
end
