class BoxesController < ApplicationController
  def destroy
    current_user.boxes.find(params[:id]).destroy
    redirect_to dashboard_path
  end
end
