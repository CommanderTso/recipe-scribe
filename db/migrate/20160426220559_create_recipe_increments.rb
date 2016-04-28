class CreateRecipeIncrements < ActiveRecord::Migration
  def change
    create_table :recipe_increments do |t|
      t.integer :quantity, default: 0
      t.belongs_to :shopping_list, null: false
      t.belongs_to :recipe, null: false

      t.timestamps null: false
    end
  end
end
