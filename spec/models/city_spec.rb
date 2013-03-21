# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  country_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe City do

  before(:each) do
    @country = Factory(:country)
    @country2 = Factory(:united_states)
    @city_name = "Chennai"
  end

  it "should create a new instance given valid attributes" do
    @city = @country.cities.new
    @city.name = @city_name
    @city.save!
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

  def get_valid_city
    valid_city = @country.cities.new
    valid_city.name = @city_name
    return valid_city
  end

  describe "validations" do

    it "should require a country id" do
      City.new(@attr).should_not be_valid
    end

    it "should require a name attribute" do
      city = @country.cities.new
      city.should_not be_valid
    end

    it "should reject duplicate city name within the same country" do
      valid_city = get_valid_city
      valid_city.save!
      lambda do
        another_city = @country.cities.new
        another_city.name = @city_name
        another_city.save!
      end.should raise_error(ActiveRecord::RecordInvalid, /name has already been taken/i)
    end

    it "should allow same city name to exist in different countries" do
      valid_city = get_valid_city
      valid_city.save!
      another_valid_city = @country2.cities.new
      another_valid_city.name = @city_name
      another_valid_city.save!
      another_valid_city.should be_valid
    end

    it "should reject any updates to the name field" do
      valid_city = get_valid_city
      lambda do
        valid_city.update(:name => "Mumbai")
      end.should raise_error(NoMethodError, /private method ['|`]update['|`] called/i)
    end

    it "should not allow access to country_id" do
      lambda do
        City.new(country_id: @country.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "airport association" do

    before(:each) do
      @city = @country.cities.new
      @city.name = @city_name
      @city.save!
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
