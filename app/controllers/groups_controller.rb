class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    current_user.groups << @group
    redirect_to @group
  end

  def show
    @group = current_user.groups.find(params[:id])
    @games = @group.games
  end

  private

  def group_params
    params.require(:group).permit(:title)
  end
end
