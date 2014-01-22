class DashboardsController < ApplicationController
  def show
    current_user.knows
  end
end
