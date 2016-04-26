class ShoppingList < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_increments

  validates_presence_of :user
end
