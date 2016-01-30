require "rails_helper"

describe "User", type: "feature" do
  let!(:user) { create(:user, email: "test@test.com") }

  before(:each) do
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Login"
  end

  it "have no cards" do
    visit root_path
    expect(page).to have_content "Поздарвляю ты знаешь"
  end

  it "succesfull add card" do
    visit new_card_path
    fill_in "card_original_text", with: "HoMe"
    fill_in "card_translated_text", with: "дом"
    click_button "Create Card"
    expect(page).to have_content "Карточка успешно создана"
  end

  it "failed add card" do
    visit new_card_path
    fill_in "card_original_text", with: "HoMe"
    fill_in "card_translated_text", with: "hOmE"
    click_button "Create Card"
    expect(page).to have_content "Оригинал не может быть равен переводу"
  end

  describe "answer" do
    before(:each) do
      @card = create(:card, user: user)
    end

    it "visit" do
      visit root_path
      expect(page).to have_content "Home"
    end

    it "right answer" do
      visit root_path
      fill_in "answer", with: @card.translated_text
      click_button "Проверить"
      expect(page).to have_content "Right"
    end

    it "wrong answer" do
      visit root_path
      fill_in "answer", with: "wrong_answer"
      click_button "Проверить"
      expect(page).to have_content "Wrong"
    end
  end
end
