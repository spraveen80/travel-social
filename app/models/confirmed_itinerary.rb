class ConfirmedItinerary < Itinerary
  has_many :flights, :dependent => :destroy
end
