class Api::V1::RoadTripController < ApplicationController
  def create
    roadtrip = RoadTripFacade.get_trip(road_trip_params)
  end

  private
  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
