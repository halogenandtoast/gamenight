require 'spec_helper'

feature 'user assigns game', :js do
  scenario 'to a location' do
    user = create(:user)
    group = create(:group, title: "Boston")
    user.groups << group
    location = create(:location, title: "Office", group: group)
    game = create(:game, title: "Archon")
    user.add_game game

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
    user.boxes.create(title: game.title, game_ids: [game.id], location: location)

    sign_in(user)
    assign_game_to("")

    click_link "Boston"
    click_link "Office"

    expect(page).not_to have_content("Archon")
  end

  def assign_game_to location
    visit root_path
    select location, from: "box[location_id]"
  end
end
