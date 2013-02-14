class CreateAirports < ActiveRecord::Migration
  def self.up
    create_table :airports do |t|
      t.string :icao_code
      t.string :name
      t.integer :city_id

      t.timestamps
    end
    add_index :airports, :name
    add_index :airports, :icao_code
  end

  def self.down
    drop_table :airports
  end
end
