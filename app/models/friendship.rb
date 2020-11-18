class Friendship < ApplicationRecord
  belongs_to :invitor, class_name: 'User'
  # validates :invitor, uniqueness: { scope: :invitee }
  validates_uniqueness_of :invitee, scope: :invitor
  validates_uniqueness_of :invitor, scope: :invitee

  belongs_to :invitee, class_name: 'User'

  after_update :create_reverse_friendship
  after_destroy :destroy_reverse_friendship, if: :reverse_friendship_exists?

  private

    def create_reverse_friendship
      Friendship.create(invitor_id: invitee_id, invitee_id: invitor_id, confirmed: true)
    end

    def destroy_reverse_friendship
      Friendship.find_by(invitor_id: invitee_id, invitee_id: invitor_id, confirmed: true).destroy
    end
    
    def reverse_friendship_exists?
      true if Friendship.find_by(invitor_id: invitee_id, invitee_id: invitor_id, confirmed: true)
    end

end
