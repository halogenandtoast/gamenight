class AddBggIdAndYearToGames < ActiveRecord::Migration
  def change
    add_column :games, :bgg_id, :string
    add_column :games, :year, :string
  end
end
