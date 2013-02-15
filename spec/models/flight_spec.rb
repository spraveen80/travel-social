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

require 'spec_helper'

describe Flight do
  before(:each) do
    @valid_attributes = {
      :from_airport_id => ,
      :dep_date => ,
      :dep_time => ,
      :to_airport_id => ,
      :arr_date => ,
      :arr_time => ,
      :airline_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Flight.create!(@valid_attributes)
  end
end
