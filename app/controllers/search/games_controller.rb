class Search::GamesController < ApplicationController
  respond_to :json

  def index
    respond_with Game.where("title ILIKE ?", "#{params[:term]}%").order("title ASC").limit(10)
  end
end
