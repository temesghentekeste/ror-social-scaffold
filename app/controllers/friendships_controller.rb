class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    other_user = User.find(params[:user_id])
    
    @friendship = Friendship.new(invitor_id: current_user.id, invitee_id: other_user.id)
    @friendship.confirmed = false
    @friendship.save
    flash[:notice] = 'Friend request sent!'


    redirect_to users_path()
  end

  def update
    other_user = User.find(params[:id])
    @friendship = Friendship.find_by(invitor_id: current_user.id, invitee_id: params[:id])
    @friendship.confirmed = true
    @friendship.save

    flash[:notice] = 'Your friendship have been confimed successfully.'
    redirect_to users_path
  end
end
