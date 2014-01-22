class RemoveGameIdsFromBoxes < ActiveRecord::Migration
  def change
    remove_column :boxes, :game_ids
  end
end
