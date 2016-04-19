class AddRecipesToUsers < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.belongs_to :user
    end
  end
end
