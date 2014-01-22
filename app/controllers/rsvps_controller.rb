class RsvpsController < ApplicationController
  def create
    group = find_group
    rsvp = current_user.rsvps.find_or_create_by(group_id: group.id)
    rsvp.update(date: group.next_date, request: params[:request] || 'new')
    redirect_to group
  end

  def update
    group = find_group
    rsvp = current_user.rsvps.find_by(group_id: group.id)
    rsvp.update(request: params[:request] || 'new')
    redirect_to group
  end

  def destroy
    group = find_group
    rsvp = current_user.rsvps.find_by(group_id: group.id)
    rsvp.date = nil
    rsvp.save
    redirect_to group
  end

  private

  def find_group
    Group.find(params[:group_id])
  end
end
