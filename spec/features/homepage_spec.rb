require 'rails_helper'

describe 'You need to sign in or sign up before continuing', type: :feature do
  before do
    visit root_url
  end
  context 'Sign in' do
    it 'should have Sign in to Private Event' do
      visit root_url
      expect(page).to have_content('Sign in')
      expect(page).to have_content('Sign up')
    end
  end
end
