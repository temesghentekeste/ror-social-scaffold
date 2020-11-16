require 'rails_helper'

RSpec.describe 'User Model Tests', type: :model do
  subject { User.new }

  describe 'validations' do
    it 'should validate presence of name' do
      subject.email = Faker::Internet.email
      expect(subject.valid?).to be false
    end
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to validate_length_of(:name).is_at_most(20) }
  end

  describe 'associations' do
    it { should have_many(:posts) }

    it { should have_many(:comments) }

    it { should have_many(:likes) }

    it { should have_many(:pending_friendships).conditions(confirmed: false).class_name('Friendship').with_foreign_key('invitor_id') }

    it { should have_many(:received_friendships).conditions(confirmed: false).class_name('Friendship').with_foreign_key('invitee_id') }

    it { should have_many(:confirmed_friendships).conditions(confirmed: true).class_name('Friendship').with_foreign_key('invitor_id') }

    it { should have_many(:pending_friends).through(:pending_friendships).source(:invitee) }
    it { should have_many(:received_friends).through(:received_friendships).source(:invitor) }
    it { should have_many(:confirmed_friends).through(:confirmed_friendships).source(:invitee) }

  end

  describe "user methods" do
    before(:example) do
      @invitor = FactoryBot.create(:user)
      @invitee = FactoryBot.create(:user)
    end

    it 'returns pending friends' do
      @invitor.send_request(@invitee)
      expect(@invitor.pending_friends).to include(@invitee)
    end

    it 'returns incoming friends' do
      expect(@invitee.received_friends).to eq([])
    end

    it "should check if user is friend with another user" do
      isFriend = @invitor.friend_with? (@invitee)
      expect(isFriend).to be false 
    end
  end
end
