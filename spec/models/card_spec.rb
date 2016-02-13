require "rails_helper"

RSpec.describe Card, type: "model" do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }

  before :each do
    @card = build(:card, user: user, deck: deck)
  end

  it "valid" do
    expect(@card).to be_valid
  end

  it "#equal_text" do
    @card.translated_text = "home"
    expect(@card).not_to be_valid
  end

  it "#return downcase translate after save" do
    @card.save
    expect(@card.translated_text).to eq("дом")
  end

  describe "check word" do
    it "has right answer" do
      @card.bucket = 2
      @card.review_date = Time.zone.now
      @card.save
      t = @card.review_date
      @card.check_word("доМ")
      expect(@card.review_date).to eq(t + 3.day)
    end

    it "right answer up level card" do
      @card.save
      @card.check_word("дом")
      expect(@card.bucket).to eq 2
    end

    it "has wrong answer" do
      @card.save
      t = @card.review_date
      @card.check_word("неправильный")
      expect(@card.review_date).to eq(t)
    end

    it "wrong answer up attemts" do
      @card.save
      @card.check_word("неправильный")
      expect(@card.attempt).to eq 1
    end

    it "3 wrong answers down cards bucket level" do
      @card.bucket = 3
      @card.attempt = 3
      @card.save
      @card.check_word("неправильный ответ")
      expect(@card.bucket).to eq 2
    end

    it "is return only need checked words" do
      user = create(:user, email: "test@gmail.com")
      deck = create(:deck, user: user)
      card1 = create(:card, user: user, deck: deck)
      card2 = create(:card, user: user, deck: deck)
      card2.check_word("дом")
      expect(Card.need_check).to match_array([card1])
    end
  end
end
