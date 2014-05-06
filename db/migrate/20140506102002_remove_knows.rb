class RemoveKnows < ActiveRecord::Migration
  def change
    drop_table :knows
  end
end
