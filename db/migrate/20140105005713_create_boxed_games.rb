class CreateBoxedGames < ActiveRecord::Migration
  def change
    create_table :boxed_games do |t|
      t.belongs_to :box, index: true
      t.belongs_to :game, index: true

      t.timestamps
    end
  end
end
