class AddLocationToGameCopies < ActiveRecord::Migration
  def change
    add_reference :game_copies, :location, index: true
  end
end
