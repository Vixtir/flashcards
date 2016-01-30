require "rails_helper"

describe "User", type: "feature" do
  let(:user) { FactoryGirl.build(:user) }

  describe "enter on the site first time" do
    it "has a meassage about login" do
      visit root_path
      expect(page).to have_content "Please login or register!!!"
    end

    it "has a link for registration" do
      visit root_path
      expect(page).to have_selector("#register")
    end

    it "have no logout link" do
      visit root_path
      expect(page).not_to have_selector("#logout")
    end

    it "has a Facebook login link" do
      visit root_path
      expect(page).to have_content "Login with Facebook"
    end
  end

  describe "#registration" do
    it "valid" do
      visit root_path
      click_link("register")
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password_confirmation
      click_button "Create User"
      expect(page).to have_content "User has been created"
    end

    it "invalid" do
      visit root_path
      click_link("register")
      click_button "Create User"
      expect(page).to have_content "errors"
    end
  end

  describe "#login" do
    let!(:user) { create(:user) }

    before(:each) do
      login("user@email.com", "password")
   end

    it "valid" do
      expect(page).to have_content "Login succefull"
    end

    it "has a logout button" do
      expect(page).to have_content "Log out"
    end

    it "has a profile link" do
      expect(page).to have_content "Profile"
    end

    it "enter into profile" do
      click_link("profile")
      expect(page).to have_content "Email"
    end
  end
end
