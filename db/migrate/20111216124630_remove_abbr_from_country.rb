class RemoveAbbrFromCountry < ActiveRecord::Migration
  def self.up
    remove_column :countries, :abbr
  end

  def self.down
    add_column    :countries, :abbr, :string
  end
end
