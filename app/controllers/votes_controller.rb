class VotesController < ApplicationController
  def update
    group = find_group
    game = find_game
    next_date = group.next_date
    current_user.votes.create(group: group, game: game, voted_for: next_date)
    redirect_to group
  end

  private

  def find_group
    @_group ||= current_user.groups.find(params[:group_id])
  end

  def find_game
    @_game ||= Game.find(params[:id])
  end
end
