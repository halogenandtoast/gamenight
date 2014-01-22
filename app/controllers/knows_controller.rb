class KnowsController < ApplicationController
  def create
    game = find_game
    current_user.knows.create(game: game)
    redirect_to :back
  end

  def destroy
    current_user.knows.find_by(game_id: params[:id]).destroy
    redirect_to :back
  end

  private

  def find_game
    Game.find(params[:id])
  end
end
