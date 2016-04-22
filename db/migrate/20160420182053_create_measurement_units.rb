class CreateMeasurementUnits < ActiveRecord::Migration
  def change
    create_table :measurement_units do |t|
      t.string :name, null: false, unique: true

      t.timestamps null: false
    end
  end
end
