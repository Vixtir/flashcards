require "rails_helper"

describe "Card", type: "feature" do
  describe "adding" do
    it "success adding card" do
      visit new_card_path
      within("#new_card") do
        fill_in "card_original_text", with: "Home"
        fill_in "card_translated_text", with: "Дом"
      end
      click_button "Create Card"
      expect(page).to have_content "Карточка успешно создана"
    end

    it "failed add card" do
      visit new_card_path
      within("#new_card") do
        fill_in "card_original_text", with: "HoMe"
        fill_in "card_translated_text", with: "hOmE"
      end
      click_button "Create Card"
      expect(page).to have_content "Оригинал не может быть равен переводу"
    end
  end

  describe "check card" do
    let!(:card) { create(:card, original_text: "Home", translated_text: "Дом") }
    it "right answer" do
      visit root_path
      within("#card_answer") do
        fill_in "answer", with: "дом"
      end
      click_button "Проверить"
      expect(page).to have_content "Right"
    end

    it "wrong answer" do
      visit root_path
      within("#card_answer") do
        fill_in "answer", with: "wrong_answer"
      end
      click_button "Проверить"
      expect(page).to have_content "Wrong"
    end
  end
end
