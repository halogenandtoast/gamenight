class AddTitleToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :title, :string
  end
end
