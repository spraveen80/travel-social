# == Schema Information
#
# Table name: itineraries
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  passenger_name  :string(255)
#  need_help       :boolean
#  willing_to_help :boolean
#  type            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe TentativeItinerary do
  before(:each) do
    @user = Factory(:user)
    @a1 = Factory(:airport)
    @a2 = Factory(:another_airport)
    @attr = {
      :user => @user,
      :type => "TentativeItinerary",
      :passenger_name => "John Doe",
      :need_help => false,
      :willing_to_help => false,
      :start_airport => @a1,
      :dest_airport => @a2
    }
  end

  it "should create a new instance given valid attributes" do
    TentativeItinerary.create!(@attr)
  end

  describe "validations" do

    before(:each) do
      @empty_airport = Airport.new
      @invalid_airport = Factory.build(:airport, :city => @a1.city, :name => "XXX Intl", :icao_code => "XXXX", :iata_code => "XXX")
    end

    it "should require a start airport" do
      TentativeItinerary.create(@attr.merge(:start_airport => @empty_airport)).should_not be_valid
    end

    it "should require a valid start airport" do
      TentativeItinerary.create(@attr.merge(:start_airport => @invalid_airport)).should_not be_valid
    end

    it "should require a dest airport id" do
      TentativeItinerary.create(@attr.merge(:dest_airport => @empty_airport)).should_not be_valid
    end

    it "should require a valid dest airport id" do
      TentativeItinerary.create(@attr.merge(:dest_airport => @invalid_airport)).should_not be_valid
    end

    it "should not have the same start and dest airports" do
      TentativeItinerary.create(@attr.merge(:dest_airport => @a1)).should_not be_valid
    end
  end
end
