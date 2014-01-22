class AddOwnerToBoxes < ActiveRecord::Migration
  def change
    add_reference :boxes, :owner, polymorphic: true, index: true
    remove_column :boxes, :user_id
  end
end
