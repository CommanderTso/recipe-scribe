class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :quantity, default: 0
      t.belongs_to :measurement_unit, null: false
      t.belongs_to :ingredient, null: false
      t.belongs_to :shopping_list, null: false

      t.timestamps null: false
    end
  end
end
