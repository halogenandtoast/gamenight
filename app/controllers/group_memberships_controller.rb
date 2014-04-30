class GroupMembershipsController < ApplicationController
  def destroy
    group = Group.find(params[:id])
    current_user.groups.delete(group)
    if group.members(true).empty?
      group.destroy
    end
    redirect_to root_path
  end
end
