class LocationsController < ApplicationController
  def show
    @location = find_location
  end

  def new
    @group = find_group
    @location = Location.new
  end

  def create
    @group = find_group
    @group.locations << Location.new(location_params)
    redirect_to @group
  end

  def update
    location = find_location
    location.update(location_params)
    redirect_to location
  end

  private

  def find_location
    current_user.locations.find(params[:id])
  end

  def find_group
    current_user.groups.find(params[:group_id])
  end

  def location_params
    params.require(:location).permit(:title, :recurrence_rules, :starts_on)
  end
end
