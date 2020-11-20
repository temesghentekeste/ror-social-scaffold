class AddUniqueIndexToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_index :friendships, [:invitor_id, :invitee_id], unique: true
  end
end
