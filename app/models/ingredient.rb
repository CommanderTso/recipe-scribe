class Ingredient < ActiveRecord::Base
  validates :name, presence: true

  has_many :recipe_ingredients
  has_many :list_items
end
