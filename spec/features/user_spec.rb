require "rails_helper"

describe "User", type: "feature" do
  let(:user) { FactoryGirl.build(:user) }

  describe "home page" do
    it "has a brand" do
        visit root_path
        expect(page).to have_content I18n.t('main.brand')
    end

    it "has a link for registration" do
      visit root_path
      expect(page).to have_content I18n.t('not_registred.link')
    end

    it "have no logout link" do
      visit root_path
      expect(page).not_to have_selector("#logout")
    end

    it "has a Facebook login link" do
      visit root_path
      expect(page).to have_content I18n.t('main.facebook_login')
    end
  end

  describe "#registration" do
    it "valid" do
      visit root_path
      click_link(I18n.t('not_registred.link'))
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password_confirmation
      click_button "Create User"
      expect(page).to have_content I18n.t('main.logout')
    end

    it "path has html5 validation" do
      visit new_home_user_path
      expect(page).to have_xpath("//input[@required='required']")
    end
  end

  describe "#login" do
    let!(:user) { create(:user) }

    before(:each) do
      login("user@email.com", "password")
    end

    it "valid" do
      expect(page).to have_content I18n.t('flash.session.login')
    end

    it "has a logout button" do
      expect(page).to have_content I18n.t('main.logout')
    end

    it "has a profile link" do
      expect(page).to have_content I18n.t('main.profile')
    end

    it "enter into profile" do
      click_link("profile")
      expect(page).to have_content "Email"
    end
  end
end
