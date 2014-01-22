class InvitationsController < ApplicationController
  def show
    @invitation = find_invitation
  end

  def new
    @group = find_group
    @invitation = Invitation.new
  end

  def create
    group = find_group
    invitation_system.invite find_user, sender: current_user, group: group
    redirect_to group
  end

  def update
    invitation = find_invitation
    user = invitation.user
    if user.status == 'invited'
      user.update(user_params.except(:password).merge(status: 'active'))
      Monban::PasswordReset.new(user, user_params[:password]).perform
      user.save
      sign_in(user)
    end
    user.groups << invitation.group
    invitation.destroy
    redirect_to invitation.group
  end

  def destroy
    find_invitation.destroy
    if signed_in?
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  private
  def find_group
    Group.find(params[:group_id])
  end

  def find_invitation
    Invitation.find_by(token: params[:id])
  end

  def invitation_system
    InvitationSystem.new
  end

  def find_user
    User.find_or_initialize_by(email: params[:invitation][:user][:email])
  end

  def user_params
    params[:invitation][:user].permit!
  end
end
