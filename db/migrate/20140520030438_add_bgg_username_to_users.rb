class AddBggUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bgg_username, :string
  end
end
