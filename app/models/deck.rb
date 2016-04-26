class Deck < ActiveRecord::Base
  belongs_to :user

  has_many :cards, dependent: :destroy

  scope :active, -> { where(status: :active) }

  validates :user, presence: true
  validates :title, presence: true

  def active?
    status == "active"
  end

  def activate
    user.decks.update_all(status: :inactive)
    self.status = "active"
  end
end
