class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :decks, dependent: :destroy

  accepts_nested_attributes_for :authentications

  validates_confirmation_of :password,
                            message: "should match confirmation",
                            if: :password
  validates :email, uniqueness: true

  def self.pending_cards
    NotificationsMailer.pending_cards(User.find_by(email: "vixtir90@gmail.com"))
  end
end
