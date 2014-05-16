require 'spec_helper'

describe Decline do
  describe "#process" do
    it "deletes existing rsvp and corresponding votes" do
      group = create(:group)
      game = create(:game)
      user = create(:user, groups: [group])
      rsvp = create(:rsvp, user: user, group: group)
      vote = create(:vote, user: user, game: game, group: group, voted_for: rsvp.date)

      decline = Decline.new(rsvp)
      decline.process

      expect(Rsvp.find(rsvp.id).date).to be_nil
      expect { Vote.find(vote.id) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
