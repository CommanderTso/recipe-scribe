class RecipeIngredient < ActiveRecord::Base
  validates :ingredient, null: false
  validates :measurement_unit, null: false
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :measurement_unit

  def to_s
    "#{self.quantity} #{self.measurement_unit.name} of #{self.ingredient.name}"
  end

  def quantity
    return if super.nil?
    if (super - super.to_i).abs < 0.001
      super.to_i
    else
      '%.2f' % super
    end
  end

  def quantity=(number)
    super((number.to_f*100).round / 100.0)
  end
end
