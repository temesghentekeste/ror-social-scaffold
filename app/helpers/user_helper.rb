module UserHelper
  def users_friendships(user)
    if current_user.friend_with?(user)
      friendship = Friendship.find_by(invitor_id: user.id, invitee_id: current_user.id)
      friendship = Friendship.find_by(invitor_id: current_user.id, invitee_id: user.id) if friendship.nil?
      render 'friend_with', { friendship: friendship, user: user }

    elsif current_user.received_friends.include?(user)
      friendship = Friendship.find_by(invitor_id: user.id, invitee_id: current_user.id)
      render 'received_friends', { friendship: friendship, user: user }

    elsif !current_user.pending_friends.include?(user)
      render 'new_users', user: user

    else
      friendship = Friendship.find_by(invitor_id: current_user.id, invitee_id: user.id)
      render 'pending_friends', { friendship: friendship, user: user }

    end
  end

  def mutual_friends_count(user)
    mutual_count = (user.confirmed_friends & current_user.confirmed_friends).count
    render 'mutual_friends_count', mutual_count: mutual_count if mutual_count.positive?
  end

  def friends_count(user)
    friends_count = user.confirmed_friends.count
    render 'friends_count', friends_count: friends_count if friends_count.positive?
  end

  def posts_count(user)
    posts_count = user.posts.count
    render 'posts_count', posts_count: posts_count if posts_count.positive?
  end
end
