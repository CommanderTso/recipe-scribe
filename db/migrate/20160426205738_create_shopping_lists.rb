class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
