class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    invited = User.find(params[:id])
    if current_user.send_request(invited)
      flash[:notice] = 'Friend request sent!'
    else
      flash[:alert] = 'Something went wrong, try again.'
    end
    redirect_to users_path
  end
  
  def update
    friendship = Friendship.find(params[:id])
    friendship.confirmed = true
    if friendship.save
      flash[:notice] = 'Your friendship have been confimed successfully.'
    else
      flash[:alert] = 'Something went wrong, try again.'
    end

    redirect_to users_path
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    if current_user == friendship.invitor
      flash[:notice] = 'Friend request is cancelled successfully'
    else
      flash[:notice] = "You have rejected the friend request successfully"
    end
    redirect_to users_path
  end

  def pending_requests
    @pending_friendships = current_user.pending_friendships
  end

  def incoming_requests
    @received_friendships = current_user.received_friendships
  end

end
