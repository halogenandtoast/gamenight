class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :title
      t.belongs_to :group, index: true

      t.timestamps
    end
  end
end
