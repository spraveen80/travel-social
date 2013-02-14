require 'spec_helper'

describe City do

  before(:each) do
    @country = Factory(:country)
    @country2 = Factory(:united_states)
    @attr = { :name => "Chennai" }
  end

  it "should create a new instance given valid attributes" do
    @country.cities.create!(@attr)
  end

  describe "country associations" do

    before(:each) do
      @city = @country.cities.create(@attr)
    end

    it "should have a country attribute" do
      @city.should respond_to(:country)
    end

    it "should have the right country associated" do
      @city.country_id.should == @country.id
      @city.country.should == @country
    end
  end

  describe "validations" do

    it "should require a country id" do
      City.new(@attr).should_not be_valid
    end

    it "should require a name attribute" do
      @country.cities.build(:name => "").should_not be_valid
    end

    it "should reject duplicate city name within the same country" do
      valid_city = @country.cities.create(@attr)
      lambda do
        @country.cities.create!(@attr)
      end.should raise_error(ActiveRecord::RecordInvalid, /name has already been taken/i)
    end

    it "should allow same city name to exist in different countries" do
      @city = @country.cities.create!(@attr)
      @country2.cities.create!(@attr).should be_valid
    end

    it "should reject any updates to the name field" do
      valid_city = @country.cities.create!(@attr)
      lambda do
        valid_city.update(:name => "Mumbai")
      end.should raise_error(NoMethodError, "Attempt to call private method")
    end
  end

  describe "airport association" do

    before(:each) do
      @city = @country.cities.create!(@attr)
      @a1 = Factory(:airport, :city => @city)
      @a2 = Factory(:airport, :city => @city, :name => "Kansas City Downtown Municipal Airport", :iata_code => "MKC", :icao_code => "KMKC")
    end

    it "should have an airports attribute" do
      @city.should respond_to(:airports)
    end

    it "should destroy associated airports" do
      @city.destroy
      [@a1, @a2].each do |airport|
        lambda do
          Airport.find(airport.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
