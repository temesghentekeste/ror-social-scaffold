require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do

    describe 'POST #create' do
      it 'creates a new friendship record' do
        @invitor = FactoryBot.create(:user)
        @invitee = FactoryBot.create(:user)

        sign_in @invitor

        expect do
          post :create, params: { id: @invitee.id }
        end .to change { Friendship.count }.from(0).to(1)
        expect(response).to redirect_to(users_path)
        expect(response).to have_http_status(302)
      end
    end

    describe 'PUT #update' do
    it 'confirms a friendship' do
      @invitor = FactoryBot.create(:user)
      sign_in @invitor
      
      @friendship = FactoryBot.create(:friendship)

      put :update, params: { id: @friendship.id, confirmed: true }
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a friendship entry from database' do
      @invitor = FactoryBot.create(:user)
      sign_in @invitor

      @friendship = FactoryBot.create(:friendship)
      expect { delete :destroy, params: { id: @friendship.id } }.to change { Friendship.count }.from(1).to(0)
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end
  end

  
end
