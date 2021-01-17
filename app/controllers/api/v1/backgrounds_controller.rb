class Api::V1::BackgroundsController < ApplicationController
  def index
    if location_params[:location].nil?

      payload = {
        error: invalid_location,
        message: 'Invailid location',
        status: 400
      }

      render json: payload, status: :bad_request
    else
      image = ImageFacade.get_image(location_params)
      render json: ImageSerializer.new(image)
    end
  end

  private
  def location_params
    params.permit(:location)
  end
end
