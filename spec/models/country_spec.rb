require 'spec_helper'

describe Country do

  before(:each) do
    @attr = {
        :name => "India",
    }
  end

  it "should create a new instance given valid attributes" do
    Country.create!(@attr)
  end

  it "should require a name" do
    no_name_country = Country.new(@attr.merge(:name => ""))
    no_name_country.should_not be_valid
  end

  it "should reject duplicate country name" do
    valid_country = Country.create!(@attr)
    lambda do
      Country.create!(@attr)
    end.should raise_error(ActiveRecord::RecordInvalid, /name has already been taken/i)
  end

  it "should reject any updates to the name field" do
    valid_country = Country.create!(@attr)
    lambda do
      valid_country.update(:name => "INDIA")
    end.should raise_error(NoMethodError, "Attempt to call private method")
  end

  describe "city association" do

    before(:each) do
      @country = Country.create(@attr)
      @c1 = Factory(:city, :country => @country)
      @c2 = Factory(:city, :country => @country, :name => "Mumbai")
    end

    it "should have a cities attribute" do
      @country.should respond_to(:cities)
    end

    it "should destroy associated cities" do
      @country.destroy
      [@c1, @c2].each do |city|
        lambda do
          City.find(city.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "airline association" do

    before(:each) do
      @country = Country.create(@attr)
      @a1 = Factory(:airline, :country => @country)
      @a2 = Factory(:airline, :country => @country, :name => "American Airlines", :iata_code => "AA", :icao_code => "AAL")
    end

    it "should have an airline attribute" do
      @country.should respond_to(:airlines)
    end

    it "should destroy associated airlines" do
      @country.destroy
      [@a1, @a2].each do |airline|
        lambda do
          Airline.find(airline.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
