class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.json :data

      t.timestamps
    end
  end
end
