saved_single_instances = {}
#Find or create the model instance
single_instances = lambda do |factory_key|
  begin
    saved_single_instances[factory_key].reload
  rescue NoMethodError, ActiveRecord::RecordNotFound
    #was never created (is nil) or was cleared from db
    saved_single_instances[factory_key] = Factory.create(factory_key)  #recreate
  end

  return saved_single_instances[factory_key]
end

Factory.define :user do |user|
  user.name                  "Praveen Srinivasan"
  user.email                 "spraveen80@gmail.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

# Countries
Factory.define :country do |country|
  country.name              "India"
end

Factory.define :united_states, :class => Country do |country|
  country.name              "United States"
end

Factory.define :germany, :class => Country do |country|
  country.name              "Germany"
end

# Cities
Factory.define :city do |city|
  city.name                 "Chennai"
  city.association          :country
end

Factory.define :chicago, :class => City do |c|
  c.name                    "Chicago"
  c.association             :country, :factory => :united_states
end

# Airports
Factory.define :airport do |airport|
  airport.name              "Chennai Intl"
  airport.icao_code         "VOMM"
  airport.iata_code         "MAA"
  airport.association       :city
end

Factory.define :another_airport, :class => Airport do |airport|
  airport.name              "Chicago Ohare Intl"
  airport.icao_code         "KORD"
  airport.iata_code         "ORD"
  airport.association       :city, :factory => :chicago
end

# Airlines
Factory.define :airline do |airline|
  airline.name              "Southwest Airlines"
  airline.alias             "\N"
  airline.iata_code         "WN"
  airline.icao_code         "SWA"
  airline.callsign          "SOUTHWEST"
  airline.active            "Y"
  airline.association       :country, :factory => :united_states
end

Factory.define :lufthansa, :class => Airline do |airline|
  airline.name              "Lufthansa"
  airline.alias             "\N"
  airline.iata_code         "LH"
  airline.icao_code         "DLH"
  airline.callsign          "LUFTHANSA"
  airline.active            "Y"
  airline.association       :country, :factory => :germany
end

# Itineraries
Factory.define :itinerary do |itin|
  itin.passenger_name       "John Doe"
  itin.need_help            true
  itin.willing_to_help      false
  itin.association          :user
end

Factory.define :can_help_itin, :class => Itinerary do |itin|
  itin.passenger_name       "Jane Doe"
  itin.need_help            false
  itin.willing_to_help      true
  itin.association          :user
end

# Flights
Factory.define :flight do |f|
  f.association             :from_airport, :factory => :airport
  f.dep_date                Date.parse('Feb 27, 2012')
  f.dep_time                Time.parse('18:30')
  f.association             :to_airport, :factory => :another_airport
  f.arr_date                Date.parse('Feb 29, 2012')
  f.arr_time                Time.parse('03:00')
  f.association             :airline, :factory => :lufthansa
  f.association             :itinerary
end

Factory.define :another_flight, :class => Flight do |f|
  f.association             :from_airport, :factory => :airport
  f.dep_date                Date.parse('Feb 27, 2012')
  f.dep_time                Time.parse('18:30')
  f.association             :to_airport, :factory => :another_airport
  f.arr_date                Date.parse('Feb 29, 2012')
  f.arr_time                Time.parse('03:00')
  f.association             :airline, :factory => :lufthansa
  f.association             :itinerary, :factory  => :can_help_itin
end
