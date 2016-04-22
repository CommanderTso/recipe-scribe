class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient, null: false
      t.belongs_to :measurement_unit, null: false
      t.float :quantity, scale: 2

      t.timestamps null: false
    end
  end
end
