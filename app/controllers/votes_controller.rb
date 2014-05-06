class VotesController < ApplicationController
  def create
    group = find_group
    next_date = group.next_date
    game = find_game
    current_user
  end

  private

  def find_group
    @_group ||= current_user.groups.find(params[:group_id])
  end

  def find_game
    @_game ||= Game.find(params[:game_id])
  end
end
