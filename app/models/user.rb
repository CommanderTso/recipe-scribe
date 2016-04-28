class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true
  validates_presence_of :shopping_list

  has_one :shopping_list
  has_many :recipes

  before_validation(on: :create) do
    self.shopping_list = ShoppingList.new
  end
end
