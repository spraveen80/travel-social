class City < ActiveRecord::Base
  attr_readonly :name

  belongs_to :country
  has_many :airports, :dependent => :destroy

  validates_presence_of   :name, :country_id
  validates_uniqueness_of :name, :scope => :country_id, :case_sensitive => false
end
