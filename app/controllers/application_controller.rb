class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login_with_token
  before_filter :set_timezone

  private

  def require_login_with_token
    current_user || sign_in_via_token
    unless signed_in?
      redirect_to new_session_path(redirect: request.url)
    end
  end

  def set_timezone
    Time.zone = current_user.time_zone
  end

  def current_user
    super || Guest.new
  end

  def sign_in_via_token
    if user_from_token
      sign_in(user_from_token)
    end
  end

  def user_from_token
    if params[:token]
      @user ||= User.find_by(token: params[:token])
    end
  end
end
