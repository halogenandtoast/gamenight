class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.integer :game_ids, array: true, default: []
      t.belongs_to :user, index: true
      t.belongs_to :location, index: true

      t.timestamps
    end
  end
end
