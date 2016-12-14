class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :name
      t.boolean :is_pink
      t.string :latitude
      t.string :longitude
      t.string :address
      t.boolean :status, default: false
      t.timestamps null: false
    end
  end
end
