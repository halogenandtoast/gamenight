class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.create(group_params)
    redirect_to @group
  end

  def show
    @group = current_user.groups.find(params[:id])
    @voted_games = @group.voted_games
    @boxes = @group.available_boxes.alphabetical.includes(:owner)
  end

  private

  def group_params
    params.require(:group).permit(:title).merge(
      time_zone: current_user.time_zone
    )
  end
end
