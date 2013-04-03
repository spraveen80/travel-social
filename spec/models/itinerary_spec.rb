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

describe Itinerary do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :type => "Itinerary",
      :passenger_name => "John Doe",
      :need_help => false,
      :willing_to_help => false
    }
  end

  def get_valid_itinerary
    return get_itinerary(@attr)
  end

  def get_itinerary(attr)
    itinerary = @user.itineraries.new
    populate(itinerary,attr)
    return itinerary
  end

  def populate(itinerary, attr)
    itinerary.type = attr[:type]
    itinerary.passenger_name = attr[:passenger_name]
    itinerary.need_help = attr[:need_help]
    itinerary.willing_to_help = attr[:willing_to_help]
  end

  it "should create a new instance given valid attributes" do
    get_valid_itinerary.save!
  end

  describe "validations" do

    it "should require a passenger name" do
      get_itinerary(@attr.merge(:passenger_name => "")).should_not be_valid
    end

    it "should require a passenger name that does not exceed 100 characters in length" do
      get_itinerary(@attr.merge(:passenger_name => "a" * 101)).should_not be_valid
    end

    it "should not have both need_help and willing_to_help set" do
      get_itinerary(@attr.merge(:need_help => true, :willing_to_help => true)).should_not be_valid
    end

    # Rails does not allow type to be validated. Adding validates_existence_of :type in 
    # itinerary model results in warning
    #   Object#type is deprecated; use Object#class
    # Looks like type is a reserved keyword
    # it "should require a type" do
    #   @user.itineraries.build(@attr.merge(:type => "")).should_not be_valid
    # end
  end

  describe "user association" do

    before(:each) do
      @itin = get_valid_itinerary
    end

    it "should have a user attribute" do
      @itin.should respond_to(:user)
    end

    it "should have the right user associated" do
      @itin.user_id.should == @user.id
      @itin.user.should == @user
    end
  end

end
