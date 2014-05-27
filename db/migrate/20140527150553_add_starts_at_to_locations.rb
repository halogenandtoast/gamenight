class AddStartsAtToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :starts_at, :time
  end
end
