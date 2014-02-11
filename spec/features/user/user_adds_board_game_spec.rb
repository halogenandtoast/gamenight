require 'spec_helper'

feature 'user adds board game' do
  scenario 'successfully' do
    create(:game, title: "Archon")
    stub_bgg_api("Archon")
    user = create(:user)
    sign_in(user)
    visit root_path
    find("a[data-role=add-game]").click
    fill_in "Title", with: "Archon"
    click_button "Add"
    expect(page).to have_css("[data-title=Archon]")
  end

  def stub_bgg_api(title)
    search_xml = fixture_file("bgg_search.xml")
    stub_request(:get, /www\.boardgamegeek\.com\/xmlapi2\/search.*/).to_return(status: 200, body: search_xml.gsub("__TITLE__", title), headers: { 'Content-Length' => search_xml.length })

    thing_xml = fixture_file("bgg_thing.xml")
    stub_request(:get, /www\.boardgamegeek\.com\/xmlapi2\/thing.*/).to_return(status: 200, body: thing_xml, headers: { "Content-Length" => thing_xml.length })
  end
end
