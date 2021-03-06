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
    expect(page).to have_content I18n.t('know_all_cards.text')
  end

  it "user have no deck" do
    visit new_dashboard_card_path
    expect(page).to have_content I18n.t('cards.no_deck.text')
  end

  describe "User with deck" do
    let!(:user) { create(:user, email: "email@test.com") }
    let!(:deck) { create(:deck, user: user) }

    before(:each) do
      login("email@test.com", "password")
    end

    it "normally login" do
      visit new_dashboard_card_path
      expect(page).to have_content I18n.t('main.add_card')
    end

    it "succesfull add card" do
      visit new_dashboard_card_path
      fill_in "card_original_text", with: "HoMe"
      fill_in "card_translated_text", with: "дом"
      click_button "Создать карточку"
      expect(page).to have_content I18n.t('flash.card.create') 
    end

    it "has Test value for select box" do
      visit new_dashboard_card_path
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
      expect(page).to have_button(I18n.t('cards.check'))
    end

    describe "check" do

      before(:each) do
        visit root_path
      end

      it "right answer", js: true do
        fill_in "answer", with: @card.translated_text
        click_button I18n.t('cards.check')
        wait_for_ajax # This is new!
        expect(page).to have_content I18n.t('know_all_cards.text')
      end

      it "right answer with 1 error", js: true do
        fill_in "answer", with: "дои"
        click_button I18n.t('cards.check')
        expect(page).to have_content I18n.t('know_all_cards.text')
      end

      it "wrong answer", js: true do
        fill_in "answer", with: "wrong_answer"
        click_button I18n.t('cards.check')
        expect(page).to have_content I18n.t('flash.card.wrong')
      end
    end
  end
end
