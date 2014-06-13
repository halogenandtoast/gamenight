class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    game = find_or_create_game
    owner.add_game(game)
    redirect_to redirection_path
  end

  private

  def owner
    if params[:location_id]
      Location.find(params[:location_id])
    else
      current_user
    end
  end

  def find_or_create_game
    if params[:game][:id].present?
      retrieve_game
    else
      GameCreator.new(title).create
    end
  end

  def retrieve_game
    Game.find_by(id: params[:game][:id]).tap do |game|
      unless game.retrieved?
        Delayed::Job.enqueue GameDataJob.new(game)
      end
    end
  end

  def title
    params[:game][:title]
  end

  def redirection_path
    if owner == current_user
      dashboard_path
    else
      owner
    end
  end
end
