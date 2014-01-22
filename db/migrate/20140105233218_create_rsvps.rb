class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.belongs_to :user, index: true
      t.belongs_to :group, index: true
      t.date :date

      t.timestamps
    end
  end
end
