class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by_email(auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      jwt = Auth.issue(user.jwt_payload)
      render json: {jwt: jwt}, status: 201
    else
      render json: {}, status: 401
    end
  end

  def auth_params
    params.require(:auth).permit(:email, :password)
  end

end
