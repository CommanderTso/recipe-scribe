class MeasurementUnit < ActiveRecord::Base
  validates :name, presence: true

  has_many :recipe_ingredients
end