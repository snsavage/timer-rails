class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate, except: [:index]

  def index
    render json: {users: User.all}, status: 200
  end

  def register
    user = User.new(user_params)
    if user.save
      jwt = Auth.issue(user.jwt_payload)
      render json: {jwt: jwt}, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  def sign_in
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
      jwt = Auth.issue(user.jwt_payload)
      render json: {jwt: jwt}, status: 201
    else
      render json: {}, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
  end
end
