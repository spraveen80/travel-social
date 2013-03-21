# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  country_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class City < ActiveRecord::Base
  attr_protected :name, :country_id

  belongs_to :country
  has_many :airports, :dependent => :destroy

  validates_presence_of   :name, :country_id
  validates_uniqueness_of :name, :scope => :country_id, :case_sensitive => false
end
