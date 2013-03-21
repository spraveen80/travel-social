# == Schema Information
#
# Table name: airlines
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  alias      :string(255)
#  iata_code  :string(255)
#  icao_code  :string(255)
#  callsign   :string(255)
#  active     :boolean
#  country_id :integer
#  created_at :datetime
#  updated_at :datetime
#

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

  def get_valid_airline
    return get_airline(@attr)
  end

  def get_airline(attr)
    airline = @country.airlines.new
    populate(airline,attr)
    return airline
  end

  def populate(airline, attr)
    airline.name =attr[:name]
    airline.alias = attr[:name]
    airline.iata_code = attr[:iata_code]
    airline.icao_code = attr[:icao_code]
    airline.callsign = attr[:callsign]
    airline.active = attr[:active]
  end

  it "should create a new instance given valid attributes" do
    get_valid_airline.save!
  end

  describe "country associations" do

    before(:each) do
      @airline = get_valid_airline
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
      get_airline(@attr.merge(:name => "")).should_not be_valid
    end

    it "should require an iata code" do
      get_airline(@attr.merge(:iata_code => "")).should_not be_valid
    end

    it "should require an icao code" do
      get_airline(@attr.merge(:icao_code => "")).should_not be_valid
    end

    it "should require an ICAO code that is not more than three characters" do
      get_airline(@attr.merge(:icao_code => "I" * 4)).should_not be_valid
    end

    it "should require an ICAO code that does not contain any character other than alphabets and numbers" do
      get_airline(@attr.merge(:icao_code => "AA?")).should_not be_valid
    end

    it "should require an ICAO code that does not contain any lower case alphabets" do
      get_airline(@attr.merge(:icao_code => "aaL")).should_not be_valid
    end

    it "should require an IATA code that is not more than two characters" do
      get_airline(@attr.merge(:iata_code => "I" * 3)).should_not be_valid
    end

    it "should require an IATA code that does not contain any character other than alphabets and numbers" do
      get_airline(@attr.merge(:iata_code => "A?")).should_not be_valid
    end

    it "should require an IATA code that does not contain any lower case alphabets" do
      get_airline(@attr.merge(:iata_code => "aA")).should_not be_valid
    end

    it "should reject a duplicate airline name" do
      valid_airline = get_valid_airline
      valid_airline.save!
      lambda do
        get_airline(@attr.merge(:icao_code => "AAL")).save!
      end.should raise_error(ActiveRecord::RecordInvalid, /name has already been taken/i)
    end

    it "should reject a duplicate airline icao_code" do
      valid_airline = get_valid_airline
      valid_airline.save!
      lambda do
        get_airline(@attr.merge(:name => "American Airlines", :iata_code => "AA")).save!
      end.should raise_error(ActiveRecord::RecordInvalid, /icao code has already been taken/i)
    end

    it "should reject a duplicate airline iata_code" do
      valid_airline = get_valid_airline
      valid_airline.save!
      lambda do
        get_airline(@attr.merge(:name => "American Airlines", :icao_code => "AAL")).save!
      end.should raise_error(ActiveRecord::RecordInvalid, /iata code has already been taken/i)
    end

    it "should reject any updates to the name field" do
      valid_airline = get_valid_airline
      valid_airline.save!
      lambda do
        valid_airline.update(:name => "SouthWest AIRLINES")
      end.should raise_error(NoMethodError, /private method ['|`]update['|`] called/i)
    end

    it "should reject any updates to the icao_code field" do
      valid_airline = get_valid_airline
      valid_airline.save!
      lambda do
        valid_airline.update(:icao_code => "AAL")
      end.should raise_error(NoMethodError, /private method ['|`]update['|`] called/i)
     end

    it "should reject any updates to the iata_code field" do
      valid_airline = get_valid_airline
      valid_airline.save!
      lambda do
        valid_airline.update(:iata_code => "AA")
      end.should raise_error(NoMethodError, /private method ['|`]update['|`] called/i)
     end

    it "should reject any updates to the callsign field" do
      valid_airline = get_valid_airline
      valid_airline.save!
      lambda do
        valid_airline.update(:callsign => "AAL")
      end.should raise_error(NoMethodError, /private method ['|`]update['|`] called/i)
     end

    it "should reject any updates to the active field" do
      valid_airline = get_valid_airline
      valid_airline.save!
      lambda do
        valid_airline.update(:active => "N")
      end.should raise_error(NoMethodError, /private method ['|`]update['|`] called/i)
     end
  end

end
