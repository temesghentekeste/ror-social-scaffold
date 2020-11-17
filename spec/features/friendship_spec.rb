require 'rails_helper'

RSpec.describe 'sending a friend request' do
  before do
    invitor = FactoryBot.create(:user)
    @invitee = FactoryBot.create(:user)

    visit root_url

    fill_in 'user_email', with: invitor.email
    fill_in 'user_password', with: invitor.password
    click_on 'Log in'

    visit '/users'
  end

  it 'An invitor can send a friend request to an @' do
    expect(current_path).to eq(users_path)
    click_on 'Send Request'
    expect(page).to have_content('Friend request sent!')
  end

  scenario 'an invitor can canel a friend request' do
    click_on 'Send Request'
    click_on 'Pending Requests'
    expect(current_path).to eq(requested_path)
    click_button 'Cancel'
    expect(current_path).to eq(users_path)
    expect(page).to have_content('Friend request is cancelled successfully')
  end

  scenario 'an invitee can confirm a friend request' do
    click_on 'Send Request'
    click_on 'Sign out'

    expect(page).to have_content('You need to sign in or sign up before continuing.')

    fill_in 'user_email', with: @invitee.email
    fill_in 'user_password', with: @invitee.password
    click_on 'Log in'
    expect(current_path).to eq('/')

    visit '/incoming'
    expect(current_path).to eq('/incoming')

    click_on 'Confirm'
    expect(page).to have_content('Your friendship have been confimed successfully.')
  end

  scenario 'an invitee can cancel a friend request' do
    click_on 'Send Request'
    click_on 'Sign out'

    expect(page).to have_content('You need to sign in or sign up before continuing.')

    fill_in 'user_email', with: @invitee.email
    fill_in 'user_password', with: @invitee.password
    click_on 'Log in'
    expect(current_path).to eq('/')

    visit '/incoming'
    expect(current_path).to eq('/incoming')

    click_on 'Cancel'
    expect(page).to have_content('You have rejected the friend request successfully')
  end
end
