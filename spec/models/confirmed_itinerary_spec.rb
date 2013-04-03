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

describe ConfirmedItinerary do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :user_id => @user.id,
      :type => "ConfirmedItinerary",
      :passenger_name => "John Doe",
      :need_help => false,
      :willing_to_help => false
     }
  end

  def get_valid_confirmed_itinerary
    return get_confirmed_itinerary(@attr)
  end

  def get_confirmed_itinerary(attr)
    confirmed_itinerary = ConfirmedItinerary.new
    populate(confirmed_itinerary,attr)
    return confirmed_itinerary
  end

  def populate(confirmed_itinerary,attr)
    confirmed_itinerary.user_id = attr[:user_id]
    confirmed_itinerary.type = attr[:type]
    confirmed_itinerary.passenger_name = attr[:passenger_name]
    confirmed_itinerary.need_help = attr[:need_help]
    confirmed_itinerary.willing_to_help = attr[:willing_to_help]
  end

  it "should create a new instance given valid attributes" do
    get_valid_confirmed_itinerary.save!
  end

  describe "flights association" do

    before(:each) do
      @itin = get_valid_confirmed_itinerary
      @f1 = Factory.build(:flight, :itinerary => @itin)
#@f2 = Factory.build(:another_flight, :itinerary => @itin)
    end

    it "should respond to flights attribute" do
      @itin.should respond_to(:flights)
    end

    it "should destroy associated itineraries" do
      @user.destroy
      [@f1].each do |f|
        lambda do
          ConfirmedItinerary.find(f.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end
end
