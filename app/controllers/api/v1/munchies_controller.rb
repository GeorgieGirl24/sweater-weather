class Api::V1::MunchiesController < ApplicationController
  def index
    munchies = MunchiesFacade.get_restaurants(munchies_params)
  end

  private
  def munchies_params
    params.permit(:origin, :destination, :food)
  end
end
