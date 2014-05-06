class RemoveTitleFromBoxes < ActiveRecord::Migration
  def change
    remove_column :boxes, :title
  end
end
