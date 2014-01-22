class AddStartsOnToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :starts_on, :date
  end
end
