require "rails_helper"

RSpec.describe Card, type: "model" do
  describe Card do
    it "is valid with o_text, t_text, date and user" do
      card = build(:card)
      expect(card).to be_valid
    end
    
    it "is invalid without original text" do
      card = build(:card, original_text: nil)
      expect(card).not_to be_valid    
    end

    it "is invalid without translated text" do
      card = build(:card, translated_text: nil)
      expect(card).not_to be_valid
    end

    it "is invalid without user" do
      card = build(:card, user_id: nil)
      expect(card).not_to be_valid
    end
    
    it "is invalid when we have equal text" do
      card = build(:card,original_text: "olOlo",translated_text: "oLoLo")
      expect(card).not_to be_valid 
    end
    
    it "return downcased translate after save" do
      card = create(:card, translated_text: "ПриВеТ")
      expect(card.translated_text).to eq("привет")
    end
    
    describe "check word"  do
      it "has right answer" do
        card = create(:card)
        t = card.review_date
        card.check_word("дОм")
        expect(card.review_date).to eq(t + 3.day)
      end
      
      it "has wrong answer" do
        card = create(:card)
        t = card.review_date
        card.check_word("холл")
        expect(card.review_date).to eq(t)
      end
    end
    
    it "is return only need checked words" do
      user = create(:user, email: "test@gmail.com")
      card1 = create(:card, user: user)
      card2 = create(:card, user: user)
      card2.check_word("дом")
      expect(Card.need_check).to match_array([card1])     
    end
  end
end
