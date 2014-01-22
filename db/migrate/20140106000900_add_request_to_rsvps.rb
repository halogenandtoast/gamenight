class AddRequestToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :request, :string
  end
end
