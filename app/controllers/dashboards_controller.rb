class DashboardsController < ApplicationController
  def show
    @boxes = current_user.boxes.alphabetical
  end
end
