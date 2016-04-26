class RecipeIncrement < ActiveRecord::Base
  belongs_to :shopping_list

  validates_presence_of :shopping_list, :recipe
end
