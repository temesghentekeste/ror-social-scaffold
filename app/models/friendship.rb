class Friendship < ApplicationRecord
  belongs_to :invitor, class_name: 'User'
  validates :invitor, uniqueness: { scope: :invitee }

  belongs_to :invitee, class_name: 'User'
end
