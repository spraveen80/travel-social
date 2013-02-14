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
