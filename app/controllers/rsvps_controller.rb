class RsvpsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  skip_before_filter :require_login, only: [:create]
  before_filter :ensure_login, only: [:create]

  def create
    group = find_group
    rsvp = find_or_create_rsvp_for(group)
    update_rsvp(rsvp)
    redirect_to group
  end

  def update
    group = find_group
    rsvp = find_rsvp_for(group)
    update_rsvp(rsvp)
    redirect_to group
  end

  private

  def rsvp_request_type
    params[:request] || 'new'
  end

  def find_rsvp_for(group)
    current_user.rsvps.find_by(group_id: group.id, date: group.next_date.to_date)
  end

  def update_rsvp(rsvp)
    rsvp_handler.new(rsvp).update
  end

  def find_or_create_rsvp_for(group)
    current_user.rsvps.find_or_create_by(group_id: group.id, date: group.next_date.to_date)
  end

  def find_group
    @group ||= Group.find(params[:group_id])
  end

  def rsvp_handler
    "#{rsvp_request_type}_rsvp_handler".classify.constantize
  end

  def ensure_login
    current_user || sign_in_via_token
    unless signed_in?
      redirect_to new_session_path(redirect: request.url)
    end
  end

  def sign_in_via_token
    if user_from_token
      sign_in(user_from_token)
    end
  end

  def user_from_token
    if params[:token]
      @user ||= User.find_by(token: params[:token])
    end
  end
end
