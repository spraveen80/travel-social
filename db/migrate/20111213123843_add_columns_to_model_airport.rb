class AddColumnsToModelAirport < ActiveRecord::Migration
  def self.up
    add_column(:airports, :iata_code, :string)
    add_column(:airports, :latitude, :float)
    add_column(:airports, :longitude, :float)
    add_column(:airports, :altitude, :integer)
    add_column(:airports, :timezone, :float)
    add_column(:airports, :dst, :string)

    add_index :airports, :iata_code
  end

  def self.down
    remove_column(:airports, :iata_code)
    remove_column(:airports, :latitude)
    remove_column(:airports, :longitude)
    remove_column(:airports, :altitude)
    remove_column(:airports, :timezone)
    remove_column(:airports, :dst)
  end
end
