class SessionsController < ApplicationController
  skip_before_filter :require_login_with_token

  def new
  end

  def create
    user = authenticate_session(session_params)

    if sign_in(user)
      redirect_to redirect_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def redirect_path
    params[:redirect] || root_path
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

