class Api::V1::UsersController < ApplicationController

  def register
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  def sign_in
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: user, status: 201
    else
      render json: {}, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
  end
end
