class ListItem < ActiveRecord::Base
  belongs_to :shopping_list
  belongs_to :measurement_unit
  belongs_to :ingredient

  validates_presence_of :shopping_list
  validates_presence_of :ingredient
  validates_presence_of :measurement_unit

  def update_quantity(direction, quantity)
    if direction == "add"
      self.quantity += quantity
    else
      self.quantity -= quantity
    end

    if self.quantity < 0 then self.quantity = 0 end

    self.save
  end

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
    super((number.to_f * 100).round / 100.0)
  end
end
