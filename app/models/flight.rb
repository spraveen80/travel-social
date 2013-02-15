# == Schema Information
#
# Table name: flights
#
#  id              :integer          not null, primary key
#  itinerary_id    :integer
#  from_airport_id :integer
#  dep_date        :date
#  dep_time        :time
#  to_airport_id   :integer
#  arr_date        :date
#  arr_time        :time
#  airline_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Flight < ActiveRecord::Base
  attr_accessible :from_airport, :dep_date, :dep_time, :to_airport, :arr_date, :arr_time, :airline

  belongs_to :from_airport, :foreign_key => 'from_airport_id', :class_name => 'Airport'
  belongs_to :to_airport, :foreign_key => 'to_airport_id', :class_name => 'Airport'
  belongs_to :airline
  belongs_to :itinerary
end
