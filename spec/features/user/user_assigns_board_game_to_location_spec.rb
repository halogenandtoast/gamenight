require 'spec_helper'

feature 'user assigns game' do
  scenario 'to a location' do
    user = create(:user)
    group = create(:group, title: "Boston")
    user.groups << group
    location = create(:location, title: "Office", group: group)
    game = create(:game, title: "Archon")
    user.games << game

    sign_in(user)
    assign_game_to("Office")

    click_link "Boston"
    click_link "Office"

    expect(page).to have_content("Archon")
  end

  scenario 'to nothing' do
    user = create(:user)
    group = create(:group, title: "Boston")
    user.groups << group
    location = create(:location, title: "Office", group: group)
    game = create(:game, title: "Archon")
    user.game_copies.create(game: game, location: location)

    sign_in(user)
    assign_game_to("")

    click_link "Boston"
    click_link "Office"

    expect(page).not_to have_content("Archon")
  end

  def assign_game_to location
    visit root_path
    select location, from: "game_copy[location_id]"
    click_button "Update"
  end
end
