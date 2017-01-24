class AddTimeZoneToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :time_zone, :string, default: "UTC"
  end
end
