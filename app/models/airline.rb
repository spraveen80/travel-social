# == Schema Information
#
# Table name: airlines
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  alias      :string(255)
#  iata_code  :string(255)
#  icao_code  :string(255)
#  callsign   :string(255)
#  active     :boolean
#  country_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Airline < ActiveRecord::Base
  attr_readonly :name, :alias, :iata_code, :icao_code, :callsign, :active

  belongs_to :country

  validates_presence_of   :name, :icao_code, :country_id
  validates_format_of     :icao_code, :with => /^[A-Z0-9][A-Z0-9][A-Z0-9]$/
  validates_format_of     :iata_code, :with => /^[A-Z0-9][A-Z0-9]$/
  validates_uniqueness_of :name, :scope => :country_id, :case_senstive => false
  validates_uniqueness_of :icao_code, :scope => :country_id, :case_sensitive => false
  validates_uniqueness_of :iata_code, :scope => :country_id, :case_sensitive => false
end
