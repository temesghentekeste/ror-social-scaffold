require 'rails_helper'

RSpec.describe 'Friendship Model Tests', type: :model do
  subject { Friendship.new }

  describe 'associations' do
    it { should belong_to(:invitor).class_name('User') }
    it { should belong_to(:invitee).class_name('User') }
  end
end
