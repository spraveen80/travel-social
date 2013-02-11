class TentativeItinerary < Itinerary
  attr_accessible :start_airport, :dest_airport

  belongs_to :start_airport, :foreign_key => 'start_airport_id', :class_name => 'Airport'
  belongs_to :dest_airport,  :foreign_key => 'dest_airport_id',  :class_name => 'Airport'

  validates_presence_of :start_airport, :dest_airport
  validate              :airport_validation

  # validates_existence is not natively supported in rails. It requires a plugin which
  # can be installed using:
  # script/plugin install http://svn.hasmanythrough.com/public/plugins/validates_existence/
  validates_existence_of :start_airport
  validates_existence_of :dest_airport

  private
    def airport_validation
      errors.add(:base, "Start and destination airport cannot be same") unless self.start_airport != self.dest_airport
    end
end
