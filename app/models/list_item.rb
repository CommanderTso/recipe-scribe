class ListItem < ActiveRecord::Base
  belongs_to :shopping_list
  belongs_to :measurement_unit
  belongs_to :ingredient

  validates_the_presence_of :shopping_list
  validates_the_presence_of :ingredient
  validates_the_presence_of :measurement_unit
end
