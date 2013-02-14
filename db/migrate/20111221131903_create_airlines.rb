class CreateAirlines < ActiveRecord::Migration
  def self.up
    create_table :airlines do |t|
      t.string :name
      t.string :alias
      t.string :iata_code
      t.string :icao_code
      t.string :callsign
      t.boolean :active
      t.integer :country_id

      t.timestamps
    end
    add_index :airlines, :name
    add_index :airlines, :icao_code
    add_index :airlines, :iata_code
  end

  def self.down
    drop_table :airlines
  end
end
