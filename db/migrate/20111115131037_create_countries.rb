class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.integer :country_id
      t.string :name
      t.string :abbr

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
