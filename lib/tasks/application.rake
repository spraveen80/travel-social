require 'csv'

namespace :db do
  desc "Raise an error unless the RAILS_ENV is development"
  task :development_environment_only do
    raise "Hey, development only you monkey!" unless Rails.env == 'development'
  end

  desc "Drop, create, migrate then seed the development database"
  task :seed => [
    'environment', 
    'db:development_environment_only',
    'db:drop',
    'db:create',
    'db:migrate',
    'db:load_airport_data',
    'db:load_airline_data'
    ]
end

namespace :db do
  desc "Seed the database described by RAILS_ENV with airport data"
  task :load_airport_data do
    CSV.foreach("db/airports_small.dat") do |row|
      city_str = row[2]
      country_str = row[3]
      iata_code = row[4]
      icao_code = row[5]

      unless iata_code.blank? or city_str.blank? or country_str.blank? or icao_code.blank?
        country = Country.find_by_name(country_str)
        if country.nil?
          country = Country.new
          country.name = country_str
          puts "Country save returned false for name " + country_str + " " + row[0] unless country.save
        end

        if country.valid?
          # TODO: City search returns nil for city names that are
          # same, but differ in just case. Fix it so those names
          # will be handled correctly. Example from airports.dat 
          # file: "El calafate" ID 4311 in Argentina
          city = country.cities.find_by_name(city_str)
          if city.nil?
            city = country.cities.new
            city.name = city_str
            puts "City save returned false for name " + city_str + " " + row[0]  unless city.save
          end

          if city.valid?
            airport = city.airports.new
            airport.name = row[1]
            airport.iata_code = row[4]
            airport.icao_code = row[5]
            airport.latitude = row[6]
            airport.longitude = row[7]
            airport.altitude = row[8]
            airport.timezone = row[9]
            airport.dst = row[10]
            puts "Airport save returned false for ID " + row[0]  unless airport.save
            unless airport.valid?
              puts airport.errors.full_messages
            end
          end
        end
      end

    end
  end

  desc "Seed the database described by RAILS_EVN with airline data"
  task :load_airline_data do
    CSV.foreach("db/airlines_small.dat") do |row|
      country_str = row[6]
      iata_code = row[3]
      icao_code = row[4]

      unless iata_code.blank? or country_str.blank? or icao_code.blank?
        country = Country.find_by_name(country_str)
        if country.nil?
          country = Country.new
          country.name = country_str
          puts "Country save returned false for name " + country_str + " " + row[0] unless country.save
        end

        if country.valid?
          airline = country.airlines.new
          airline.name = row[1]
          airline.alias = row[2]
          airline.iata_code = iata_code
          airline.icao_code = icao_code
          airline.callsign = row[5]
          airline.active = row[7]
          puts "Airline save returned false for ID " + row[0]  unless airline.save
          unless airline.valid?
            puts airline.errors.full_messages
          end
        end
      end

    end
  end
end
