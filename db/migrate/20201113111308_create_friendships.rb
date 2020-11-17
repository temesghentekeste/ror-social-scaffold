class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :invitor, index: true
      t.references :invitee, index: true
      t.boolean :confirmed

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :invitor_id
    add_foreign_key :friendships, :users, column: :invitee_id
  end
end
