class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    other_user = User.find(params[:user_id])
    
    @freindship = Friendship.new(invitor_id: current_user.id, invitee_id: other_user.id)
    @freindship.pending!
    @freindship.save
    flash[:notice] = 'Friend request sent!'


    redirect_to users_path()
  end
end
