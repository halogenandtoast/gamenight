require 'spec_helper'

feature 'guest signs up' do
  scenario 'succesfully' do
    pending
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign up'
    expect(page).to have_css('#dashboard')
  end
end
