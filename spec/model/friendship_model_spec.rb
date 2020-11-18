require 'rails_helper'

RSpec.describe 'Friendship Model Tests', type: :model do
  subject { Friendship.new }
  
  describe 'validations' do
    it 'should validate presence of name' do
      invitor = FactoryBot.create(:user)
      invitee = FactoryBot.create(:user)

      
      expect {  invitor.send_request(invitee) }.to change { Friendship.count }.from(0).to(1)
      
      expect {
        invitor.send_request(invitee)
      }.to raise_error(ActiveRecord::RecordInvalid)


    end
  end

  describe 'associations' do
    it { should belong_to(:invitor).class_name('User') }
    it { should belong_to(:invitee).class_name('User') }
  end

  describe 'friendship callbacks' do
    before(:example) do
      @invitor = FactoryBot.create(:user)
      @invitee = FactoryBot.create(:user)
    end

    it 'creates a reverse friendship entry in the database' do
      @invitor.send_request(@invitee)
      @friendship = Friendship.first
      @friendship.confirmed = true
     
      expect {  @friendship.save }.to change { Friendship.count }.from(1).to(2)
    end

    it 'destroy a both friendship entries in the database' do
      @invitor.send_request(@invitee)
      @friendship = Friendship.first
      @friendship.confirmed = true
     
      expect {  @friendship.save }.to change { Friendship.count }.from(1).to(2)
      
      
      expect {  @friendship.destroy }.to change { Friendship.count }.from(2).to(0)
    end

  end
end
