class DashboardsController < ApplicationController

  def show
    @boxes = current_user.boxes.includes(:game).alphabetical
  end

end
