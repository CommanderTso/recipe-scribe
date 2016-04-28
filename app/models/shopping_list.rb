class ShoppingList < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_increments
  has_many :list_items

  validates_presence_of :user

  def list_items
    super || []
  end
end
