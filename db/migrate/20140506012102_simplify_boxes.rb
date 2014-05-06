class SimplifyBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :game_id, :integer
    drop_table :boxed_games
  end
end
