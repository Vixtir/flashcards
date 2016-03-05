require "rails_helper"

RSpec.describe Card, type: "model" do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }

  before :each do
    @card = build(:card, user: user, deck: deck)
  end

  it "valid" do
    expect(@card).to be_valid
  end

  it "#equal_text" do
    @card.translated_text = "home"
    expect(@card).not_to be_valid
  end

  it "#return downcase translate after save" do
    @card.save
    expect(@card.translated_text).to eq("дом")
  end

end
