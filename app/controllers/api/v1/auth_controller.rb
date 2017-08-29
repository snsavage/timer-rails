class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by(email: auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      jwt = Auth.issue(user.jwt_payload)
      response = {
        jwt: jwt,
        id: user.id,
        email: user.email,
        name: user.first_name
      }
      render json: response, status: 201
    else
      render json: {}, status: 401
    end
  end

  def auth_params
    params.require(:auth).permit(:email, :password)
  end
end
