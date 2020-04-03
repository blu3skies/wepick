require 'rails_helper'

RSpec.feature 'adding friends', type: :feature do
  scenario 'User can add friends' do
    User.create(email: 'signin_test@example.com', password: '123456')
    create_test_user_and_login('signin_test2@example.com','123456')
    click_link('Add friend', match: :first)
    expect(current_path).to eq('/friendships/show')
    expect(page).to have_content('signin_test@example.com')
    click_button("Start Game")
    expect(page).to have_content("Start Swiping")
  end

end