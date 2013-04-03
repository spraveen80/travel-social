# == Schema Information
#
# Table name: itineraries
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  passenger_name  :string(255)
#  need_help       :boolean
#  willing_to_help :boolean
#  type            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class TentativeItinerary < Itinerary
  attr_accessible :start_airport, :dest_airport

  belongs_to :start_airport, :foreign_key => 'start_airport_id', :class_name => 'Airport'
  belongs_to :dest_airport,  :foreign_key => 'dest_airport_id',  :class_name => 'Airport'

  validates_presence_of :start_airport, :dest_airport
  validate              :airport_validation

  # validates_existence is not natively supported in rails. It requires a plugin which
  # can be installed using by specifying gem "validates_existence", "0.5.3" in the Gemfile
  validates_existence_of :start_airport
  validates_existence_of :dest_airport

  private
    def airport_validation
      errors.add(:base, "Start and destination airport cannot be same") unless self.start_airport != self.dest_airport
    end
end
