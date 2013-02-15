# == Schema Information
#
# Table name: airports
#
#  id         :integer          not null, primary key
#  icao_code  :string(255)
#  name       :string(255)
#  city_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  iata_code  :string(255)
#  latitude   :float
#  longitude  :float
#  altitude   :integer
#  timezone   :float
#  dst        :string(255)
#

require 'spec_helper'

describe Airport do

  before(:each) do
    @city = Factory(:city)
    @attr = {
      :name => "Kansas City International Airport",
      :icao_code => "KMCI",
      :iata_code => "MCI"
    }
  end

  it "should create a new instance given valid attributes" do
    @city.airports.create!(@attr)
  end

  describe "city associations" do

    before(:each) do
      @airport = @city.airports.create(@attr)
    end

    it "should have a city attribute" do
      @airport.should respond_to(:city)
    end

    it "should have the right city associated" do
      @airport.city_id.should == @city.id
      @airport.city.should == @city
    end
  end

  describe "validations" do

    it "should require a city id" do
      Airport.new(@attr).should_not be_valid
    end

    it "should require a name attribute" do
      @city.airports.build(@attr.merge(:name => "")).should_not be_valid
    end

    it "should require an ICAO code" do
      @city.airports.build(@attr.merge(:icao_code => "")).should_not be_valid
    end

    it "should require an ICAO code that is not more than four characters" do
      @city.airports.build(@attr.merge(:icao_code => "I" * 5)).should_not be_valid
    end

    it "should require an ICAO code that does not contain any character other than alphabets and numbers" do
      @city.airports.build(@attr.merge(:icao_code => "I?5G")).should_not be_valid
    end

    it "should require an ICAO code that does not contain any lower case alphabets" do
      @city.airports.build(@attr.merge(:icao_code => "kmCI")).should_not be_valid
    end

    it "should require an IATA code that is not more than three characters" do
      @city.airports.build(@attr.merge(:iata_code => "I" * 4)).should_not be_valid
    end

    it "should require an IATA code that does not contain any character other than alphabets and numbers" do
      @city.airports.build(@attr.merge(:iata_code => "I?G")).should_not be_valid
    end

    it "should require an IATA code that does not contain any lower case alphabets" do
      @city.airports.build(@attr.merge(:iata_code => "mCI")).should_not be_valid
    end

    it "should reject a duplicate airport name" do
      valid_airport = @city.airports.create!(@attr)
      lambda do
        @city.airports.create!(@attr.merge(:icao_code => "KCI"))
      end.should raise_error(ActiveRecord::RecordInvalid, /name has already been taken/i)
    end

    it "should reject a duplicate airport icao_code" do
      valid_airport = @city.airports.create!(@attr)
      lambda do
        @city.airports.create!(@attr.merge(:name => "Missouri International airport"))
      end.should raise_error(ActiveRecord::RecordInvalid, /icao code has already been taken/i)
    end

    it "should reject a duplicate airport iata_code" do
      valid_airport = @city.airports.create!(@attr)
      lambda do
        @city.airports.create!(@attr.merge(:name => "Missouri International airport", :icao_code => "KSMO" ))
      end.should raise_error(ActiveRecord::RecordInvalid, /iata code has already been taken/i)
    end

  it "should reject any updates to the name field" do
      valid_airport = @city.airports.create!(@attr)
      lambda do
        valid_airport.update(:name => "Missouri International Airport")
      end.should raise_error(NoMethodError, "Attempt to call private method")
    end

    it "should reject any updates to the icao_code field" do
      valid_airport = @city.airports.create!(@attr)
      lambda do
        valid_airport.update(:icao_code => "KCI")
      end.should raise_error(NoMethodError, "Attempt to call private method")
     end
  end
end
