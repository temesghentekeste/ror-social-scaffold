require 'rails_helper'

feature 'user authentication', type: :feature do

  feature 'signing up a user' do
    scenario 'failing test with invalid params' do
      visit new_user_registration_path
      fill_in 'user_name', with: 'Fake Name'
      click_on 'Sign up'

      expect(current_path).to eq(users_path)
      expect(page).to have_content("prohibited this user from being saved:")
    end

    scenario 'successful test with valid params' do
      create_user
  
      expect(current_path).to eq('/')
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  feature 'signing in an existing user' do
    scenario 'failing test with invalid params' do
      create_user
      click_on 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: 'fakemail@fake.com'
      click_on 'Log in'

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content('Invalid Email or password.')
    end

    scenario 'successful test with valid params' do
      create_user
      click_on 'Sign out'
      fill_in 'user_email', with: 'johndoe@somemail.com'
      fill_in 'user_password', with: 'password'
      click_on 'Log in'

      expect(current_path).to eq('/')
      expect(page).to have_content('Signed in successfully.')
    end
  end
   
  def create_user
    visit new_user_registration_path
    fill_in 'user_name', with: 'John Doe'
    fill_in 'user_email', with: 'johndoe@somemail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Sign up'
  end
  
end
