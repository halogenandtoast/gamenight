class AssignmentsController < ApplicationController
  def update
    box = current_user.boxes.find(params[:id])
    box.update(location: find_location)
    redirect_to dashboard_path
  end

  private

  def find_location
    current_user.locations.find_by_id(params[:box][:location_id])
  end
end
