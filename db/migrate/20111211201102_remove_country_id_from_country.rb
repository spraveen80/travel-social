class RemoveCountryIdFromCountry < ActiveRecord::Migration
  def self.up
    remove_column :countries, :country_id
  end

  def self.down
    add_column :countries, :country_id, :integer
  end
end
