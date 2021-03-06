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
    User.joins(:cards).where('cards.review_date < ?', Time.zone.now).group("users.id").each do |user|
      NotificationsMailer.pending_cards(user).deliver_now
    end
  end
end
