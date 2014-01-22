class AddSenderToInvitations < ActiveRecord::Migration
  def change
    add_reference :invitations, :sender, index: true
  end
end
