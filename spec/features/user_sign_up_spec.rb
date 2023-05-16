require 'rails_helper'

RSpec.feature 'User Sign Up', type: :feature, js: true do
  scenario 'creates a new user after sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'

    click_button 'Sign up'

    expect(User.count).to eq(1)
    expect(User.last.email).to eq('user@example.com')
    # Add more expectations as needed
  end
end