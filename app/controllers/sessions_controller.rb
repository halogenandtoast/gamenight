class SessionsController < ApplicationController
  respond_to :html

  def new
  end

  def create
    user = authenticate_session(session_params)
    sign_in(user) do
      respond_with(user, location: redirect_path) and return
    end
    render :new
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

