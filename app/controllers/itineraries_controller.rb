class ItinerariesController < ApplicationController
  before_filter :signed_in_user

  def new
    @itinerary = Itinerary.new
    @page_title = "New Itinerary"
  end

  def create
  end

  def destroy
  end
end
