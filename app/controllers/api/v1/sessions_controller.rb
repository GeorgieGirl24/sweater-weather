class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: sessions_params[:email])
    if user && user.authenticate(sessions_params[:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render body: generate_error(user), status: 404
    end
  end

  private

  def generate_error(user)
    error = 'Invaild creditials. Please try again'
  end

  def sessions_params
    params.permit(:email, :password)
  end
end
