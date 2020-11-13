class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :pending_friendships, -> { where confirmed: false}, class_name: 'Friendship', foreign_key: 'invitor_id', dependent: :destroy

  has_many :received_friendships,  -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'invitee_id', dependent: :destroy

  has_many :confirmed_friendships,  -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'invitor_id', dependent: :destroy

  has_many :pending_friends, through: :pending_friendships, source: :invitee
  has_many :received_friends, through: :received_friendships, source: :invitor
  has_many :confirmed_friends, through: :confirmed_friendships, source: :invitee


  def send_request(user)
    pending_friendships.create!(invitee_id: user.id, confirmed: false)
  end

  def confirm_request(user)
    friendship = received_friendships.find_by(invitor_id: user.id)
    friendship.confirmed = true
    friendship.save
  end

  def sent_request?(user)
    pending_friends.include?(user)
  end
  
  def friends_with?(user)
    confirmed_friends.include?(user) || user.confirmed_friends.include?(self)
  end
end
