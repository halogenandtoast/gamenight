require 'spec_helper'

feature 'user adds location' do
  scenario 'successfully' do
    user = create(:user)
    group = create(:group, title: "Boston")
    user.groups << group
    sign_in(user)
    visit root_path
    click_link 'Boston'
    click_link 'Add location'
    fill_in "Title", with: "Office"
    click_button "Add"
    expect(page).to have_content("Office")
  end
end
