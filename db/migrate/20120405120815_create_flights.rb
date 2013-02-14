class CreateFlights < ActiveRecord::Migration
  def self.up
    create_table :flights do |t|
      t.integer :itinerary_id
      t.integer :from_airport_id
      t.date :dep_date
      t.time :dep_time
      t.integer :to_airport_id
      t.date :arr_date
      t.time :arr_time
      t.integer :airline_id

      t.timestamps
    end
  end

  def self.down
    drop_table :flights
  end
end
