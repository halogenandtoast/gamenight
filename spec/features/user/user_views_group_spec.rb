require 'spec_helper'

feature 'user views group' do
  scenario 'sees board games' do
    user = create(:user)
    group = create(:group, title: "Boston")
    user.groups << group
    location = create(:location, title: "Office", group: group)
    game = create(:game, title: "Archon")
    user.game_copies.create(game: game, location: location)

    sign_in(user)
    visit dashboard_path
    click_link "Boston"

    expect(page).to have_content("Archon")
  end
end
