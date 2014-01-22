class AddScheduleToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :recurrence_rules, :text
  end
end
