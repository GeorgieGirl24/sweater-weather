class Api::V1::BackgroundsController < ApplicationController
  def index
    if location_params[:location].empty?
      render json: generate_error, status: 400
    else
      image = ImageFacade.get_image(location_params)
      render json: ImageSerializer.new(image)
    end
  end

  private

  def generate_error
    { error: 'Unable to find image without location' }
  end

  def location_params
    params.permit(:location)
  end
end
