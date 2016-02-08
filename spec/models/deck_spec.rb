require 'rails_helper'

RSpec.describe Deck, type: :model do
  let!(:user) { create(:user, email: "deck@email.com") }

  before(:each) do
    @deck = create(:deck, user: user)
  end

  it "default inactive status" do
    expect(@deck.active?).to be false
  end

  it "active after activete" do
    @deck.activate
    expect(@deck.active?).to be true
  end

  describe "#active scope" do
    let!(:user) { create(:user, email: "deck@email.com") }

    it "only 1 active deck" do
      deck1 = create(:deck, user: user)
      deck2 = create(:deck, user: user)
      deck1.activate
      deck1.save
      deck2.activate
      deck2.save
      expect(user.decks.active.count).to eq 1
    end
  end
end
