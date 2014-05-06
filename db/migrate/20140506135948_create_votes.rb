class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true
      t.belongs_to :group, index: true
      t.date :voted_for, null: false
    end
  end
end
