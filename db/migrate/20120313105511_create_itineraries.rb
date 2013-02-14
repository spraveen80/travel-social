class CreateItineraries < ActiveRecord::Migration
  def self.up
    create_table :itineraries do |t|
      t.integer :user_id
      t.string :passenger_name
      t.boolean :need_help
      t.boolean :willing_to_help
      t.string :type
      t.integer :start_airport_id
      t.integer :dest_airport_id

      t.timestamps
    end
  end

  def self.down
    drop_table :itineraries
  end
end
