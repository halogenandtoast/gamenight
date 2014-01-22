require 'spec_helper'

feature 'user adds group' do
  scenario 'successfully' do
    user = create(:user)
    sign_in(user)
    visit root_path
    click_link 'Add group'
    fill_in "Title", with: "Boston"
    click_button "Add"
    expect(page).to have_content("Boston")
  end
end
