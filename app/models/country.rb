# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Country < ActiveRecord::Base
  attr_readonly :name

  has_many :cities,   :dependent => :destroy
  has_many :airlines, :dependent => :destroy

  validates_presence_of   :name
  validates_uniqueness_of :name, :case_sensitive => false
end
