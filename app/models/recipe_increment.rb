class RecipeIncrement < ActiveRecord::Base
  belongs_to :shopping_list
  belongs_to :recipe

  validates_presence_of :shopping_list, :recipe
end
