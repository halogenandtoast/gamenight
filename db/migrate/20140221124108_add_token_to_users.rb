class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string, unique: true
  end
end
