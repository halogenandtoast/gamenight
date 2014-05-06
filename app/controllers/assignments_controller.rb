class AssignmentsController < ApplicationController
  def update
    box = current_user.boxes.find_by(params[:box_id])
    box.update(location_id: params[:box][:location_id])
    redirect_to dashboard_path
  end
end
