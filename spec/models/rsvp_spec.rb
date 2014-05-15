require 'spec_helper'

describe Rsvp, "#destroy" do
  it "destroys votes for its  user and group" do
    group = create(:group)
    user = create(:user, groups: [group])
    game = create(:game)
    rsvp = create(:rsvp, user: user, group: group)
    vote = create(:vote, user: user, game: game, group: group, voted_for: rsvp.date)

    rsvp.destroy

    expect { Vote.find(vote.id) }.to raise_error ActiveRecord::RecordNotFound
  end
end
