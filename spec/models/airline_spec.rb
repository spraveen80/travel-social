require 'spec_helper'

describe Airline do

  before(:each) do
    @country = Factory(:country)
    @attr = {
      :name => "Southwest Airlines",
      :alias => "\N",
      :iata_code => "WN",
      :icao_code => "SWA",
      :callsign => "SOUTHWEST",
      :active => "Y"
    }
  end

  it "should create a new instance given valid attributes" do
    @country.airlines.create!(@attr)
  end

  describe "country associations" do

    before(:each) do
      @airline = @country.airlines.create(@attr)
    end

    it "should have a country attribute" do
      @airline.should respond_to(:country)
    end

    it "should have the right country associated" do
      @airline.country_id.should == @country.id
      @airline.country.should == @country
    end
  end

  describe "validations" do

    it "should require a name" do
      no_name_airline = @country.airlines.create(@attr.merge(:name => ""))
      no_name_airline.should_not be_valid
    end

    it "should require an iata code" do
      no_iata_airline = @country.airlines.create(@attr.merge(:iata_code => ""))
      no_iata_airline.should_not be_valid
    end

    it "should require an icao code" do
      no_icao_airline = @country.airlines.create(@attr.merge(:icao_code => ""))
      no_icao_airline.should_not be_valid
    end

    it "should require an ICAO code that is not more than three characters" do
      @country.airlines.build(@attr.merge(:icao_code => "I" * 4)).should_not be_valid
    end

    it "should require an ICAO code that does not contain any character other than alphabets and numbers" do
      @country.airlines.build(@attr.merge(:icao_code => "AA?")).should_not be_valid
    end

    it "should require an ICAO code that does not contain any lower case alphabets" do
      @country.airlines.build(@attr.merge(:icao_code => "aaL")).should_not be_valid
    end

    it "should require an IATA code that is not more than two characters" do
      @country.airlines.build(@attr.merge(:iata_code => "I" * 3)).should_not be_valid
    end

    it "should require an IATA code that does not contain any character other than alphabets and numbers" do
      @country.airlines.build(@attr.merge(:iata_code => "A?")).should_not be_valid
    end

    it "should require an IATA code that does not contain any lower case alphabets" do
      @country.airlines.build(@attr.merge(:iata_code => "aA")).should_not be_valid
    end

    it "should reject a duplicate airline name" do
      valid_airport = @country.airlines.create!(@attr)
      lambda do
        @country.airlines.create!(@attr.merge(:icao_code => "AAL"))
      end.should raise_error(ActiveRecord::RecordInvalid, /name has already been taken/i)
    end

    it "should reject a duplicate airline icao_code" do
      valid_airport = @country.airlines.create!(@attr)
      lambda do
        @country.airlines.create!(@attr.merge(:name => "American Airlines", :iata_code => "AA"))
      end.should raise_error(ActiveRecord::RecordInvalid, /icao code has already been taken/i)
    end

    it "should reject a duplicate airline iata_code" do
      valid_airport = @country.airlines.create!(@attr)
      lambda do
        @country.airlines.create!(@attr.merge(:name => "American Airlines", :icao_code => "AAL"))
      end.should raise_error(ActiveRecord::RecordInvalid, /iata code has already been taken/i)
    end

    it "should reject any updates to the name field" do
      valid_airport = @country.airlines.create!(@attr)
      lambda do
        valid_airport.update(:name => "SouthWest AIRLINES")
      end.should raise_error(NoMethodError, "Attempt to call private method")
    end

    it "should reject any updates to the icao_code field" do
      valid_airport = @country.airlines.create!(@attr)
      lambda do
        valid_airport.update(:icao_code => "AAL")
      end.should raise_error(NoMethodError, "Attempt to call private method")
     end

    it "should reject any updates to the iata_code field" do
      valid_airport = @country.airlines.create!(@attr)
      lambda do
        valid_airport.update(:iata_code => "AA")
      end.should raise_error(NoMethodError, "Attempt to call private method")
     end

    it "should reject any updates to the callsign field" do
      valid_airport = @country.airlines.create!(@attr)
      lambda do
        valid_airport.update(:callsign => "AAL")
      end.should raise_error(NoMethodError, "Attempt to call private method")
     end

    it "should reject any updates to the active field" do
      valid_airport = @country.airlines.create!(@attr)
      lambda do
        valid_airport.update(:active => "N")
      end.should raise_error(NoMethodError, "Attempt to call private method")
     end
  end

end
