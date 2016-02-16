require "rails_helper"
require "spec_helper"
require "capybara/rspec"

describe "Card", type: "feature" do
  let!(:user) { create(:user, email: "email@test.com") }
  before(:each) do
    login("email@test.com", "password")
  end

  it "have no cards" do
    visit root_path
    expect(page).to have_content "Поздарвляю ты знаешь"
  end

  it "user have no deck" do
    visit new_card_path
    expect(page).to have_content "У вас еще нет колоды"
  end

  describe "User with deck" do
    let!(:user) { create(:user, email: "email@test.com") }
    let!(:deck) { create(:deck, user: user) }

    before(:each) do
      login("email@test.com", "password")
    end

    it "normally login" do
      visit new_card_path
      expect(page).to have_content "New card"
    end

    it "succesfull add card" do
      visit new_card_path
      fill_in "card_original_text", with: "HoMe"
      fill_in "card_translated_text", with: "дом"
      click_button "Create Card"
      expect(page).to have_content "Карточка успешно создана"
    end

    it "has Test value for select box" do
      visit new_card_path
      expect(page).to have_content "Тест"
    end
  end

  describe "answer" do
    let!(:user) { create(:user, email: "email@test.com") }
    let!(:deck) { create(:deck, user: user) }

    before(:each) do
      login("email@test.com", "password")
    end

    before(:each) do
      @card = create(:card, user: user, deck: deck)
    end

    it "visit" do
      visit root_path
      expect(page).to have_content "Home"
    end

    it "right answer" do
      visit root_path
      fill_in "answer", with: @card.translated_text
      click_button "Проверить"
      expect(page).to have_content "Правильно"
    end

    it "right answer with 1 error" do
      visit root_path
      fill_in "answer", with: "дои"
      click_button "Проверить"
      expect(page).to have_content "Ответ верный, но ты допустил ошибку"
    end

    it "wrong answer" do
      visit root_path
      fill_in "answer", with: "wrong_answer"
      click_button "Проверить"
      expect(page).to have_content "Неправильно"
    end
  end
end
