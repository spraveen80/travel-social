# == Schema Information
#
# Table name: airports
#
#  id         :integer          not null, primary key
#  icao_code  :string(255)
#  name       :string(255)
#  city_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  iata_code  :string(255)
#  latitude   :float
#  longitude  :float
#  altitude   :integer
#  timezone   :float
#  dst        :string(255)
#

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
