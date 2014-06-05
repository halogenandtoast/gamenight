class BoxesController < ApplicationController
  def destroy
    owner.boxes.find(params[:id]).destroy
    redirect_to dashboard_path
  end

  private

  def owner
    if params[:location_id]
      current_user.locations.find(params[:location_id])
    else
      current_user
    end
  end
end
