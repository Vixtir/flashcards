require "rails_helper"

RSpec.describe User, type: :model do
  describe "User#" do
    let(:user) { FactoryGirl.build(:user) }

    it "valid user" do
      expect(user).to be_valid
    end

    it "respond to email" do
      expect(user).to respond_to(:email)
    end

    describe "email field" do
      let(:user) { FactoryGirl.build(:user) }
      let(:user2) { FactoryGirl.build(:user) }
 
      it "email field empty" do
        user.email = nil
        expect(user).not_to be_valid
      end

      it "invalid format" do
        user.email = "acv*fsc.com"
        expect(user).not_to be_valid
      end

      it "not unique email" do
        user.save
        expect(user2).not_to be_valid
      end
    end
  end
end
