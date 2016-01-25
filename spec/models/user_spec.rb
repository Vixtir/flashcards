require "rails_helper"

RSpec.describe User, type: :model do
  describe "User#" do
    let(:user) { FactoryGirl.create(:user) }

    it "respond to email" do
      expect(user).to respond_to(:email)
    end

    it "respond to password" do
      expect(user).to respond_to(:password)
    end
  end
end
