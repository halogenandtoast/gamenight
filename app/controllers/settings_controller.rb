class SettingsController < ApplicationController
  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
