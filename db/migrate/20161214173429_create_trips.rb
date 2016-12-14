class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :car_id
      t.timestamp :start_time
      t.timestamp :end_time
      t.string :price
      t.timestamps null: false
    end
  end
end
