class Flight < ActiveRecord::Base
  attr_accessible :from_airport, :dep_date, :dep_time, :to_airport, :arr_date, :arr_time, :airline

  belongs_to :from_airport, :foreign_key => 'from_airport_id', :class_name => 'Airport'
  belongs_to :to_airport, :foreign_key => 'to_airport_id', :class_name => 'Airport'
  belongs_to :airline
  belongs_to :itinerary
end
