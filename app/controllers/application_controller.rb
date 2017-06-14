class ApplicationController < ActionController::API
  include Pundit

  before_action :authenticate
  before_action :ensure_json_request

  respond_to :json

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def ensure_json_request
    return if request.format == :json
    render :nothing => true, :status => 406
  end

  def logged_in?
    !!current_user
  end

  def current_user
    if auth_present?
      user = User.find(auth["id"])
      if user
        @current_user ||= user
      end
    else
      Guest.new
    end
  end

  def authenticate
    render json: {error: "unauthorized"}, status: 401 unless logged_in?
  end

  private

  def user_not_authorized
    render json: {}, status: 403
  end

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    !!request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first
  end

end
