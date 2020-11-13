class Friendship < ApplicationRecord

  enum confirmed: { pending: 0, confirmed: 1 }

  belongs_to :invitor, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

end
