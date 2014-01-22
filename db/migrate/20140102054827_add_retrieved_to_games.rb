class AddRetrievedToGames < ActiveRecord::Migration
  def change
    add_column :games, :retrieved, :boolean, default: false
  end
end
