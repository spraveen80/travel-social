class Airport < ActiveRecord::Base
  attr_readonly :name, :icao_code

  belongs_to :city

  validates_presence_of   :name, :icao_code, :city_id
  validates_format_of     :icao_code, :with => /^[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]$/
  validates_format_of     :iata_code, :with => /^[A-Z0-9][A-Z0-9][A-Z0-9]$/
  validates_uniqueness_of :name, :scope => :city_id, :case_sensitive => false
  validates_uniqueness_of :icao_code, :scope => :city_id, :case_sensitive => false
  validates_uniqueness_of :iata_code, :scope => :city_id, :case_sensitive => false
end
