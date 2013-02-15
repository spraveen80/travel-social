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
      :user => @user,
      :type => "ConfirmedItinerary",
      :passenger_name => "John Doe",
      :need_help => false,
      :willing_to_help => false
     }
  end

  it "should create a new instance given valid attributes" do
    ConfirmedItinerary.create!(@attr)
  end

  describe "flights association" do

    before(:each) do
      @itin = ConfirmedItinerary.create(@attr)
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
