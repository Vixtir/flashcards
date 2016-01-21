require "rails_helper"

RSpec.describe Card, :type => :model do
  describe Card
    let(:card){ FactoryGirl.create(:card)}

    it "has a valid factory" do
      expect(card).to be_valid
    end
     
    it "is invalid when original eq translate" do
      card.translated_text = "Home"
      expect(card).not_to be_valid
    end

    it "save downcase translate text" do
      card.original_text = "ДоМ"
      expect(card.translated_text).to eq("дом")
    end

  describe "sort method" do
   let(:card1){ FactoryGirl.create(:card, original_text: "Yellow", translated_text: "Желтый") }
   let(:card2){ FactoryGirl.create(:card, original_text: "Red", translated_text: "Красный") }

    it "return sorted" do
      expect(Card.need_check).to match_array([card1, card2])
    end

    it "return after check word" do
      card2.check_word("Красный")
      expect(Card.need_check).to match_array([card1])
    end
  end

  describe "#check_word" do
    context "users wrong answer" do
      it "dont adding reviews days" do
        date = card.review_date
        card.check_word("хаус")
        expect(card.review_date).to eq(date)
      end
    end

    context "users right answer" do
      it "add review date" do
        date = card.review_date
        card.check_word("дом")
        expect(card.review_date).to eq(date + 3.day)
      end
    end
  end
end

