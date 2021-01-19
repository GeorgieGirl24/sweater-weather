class Api::V1::MunchiesController < ApplicationController
  def index
    munchies = MunchiesFacade.get_restaurant(munchies_params)
  end

  private
  def munchies_params
    params.permit(:start, :end, :food)
  end
end
