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

class Itinerary < ActiveRecord::Base
  attr_accessible :passenger_name, :need_help, :willing_to_help

  belongs_to :user

  validates_presence_of :passenger_name
  validates_length_of   :passenger_name, :maximum => 100
  validate              :help_validation

  private
    def help_validation
      if self.need_help == true and self.willing_to_help == true then
        errors.add(:base, "Please indicate if the passenger needs help or is able to provide help.")
      end
    end
end
