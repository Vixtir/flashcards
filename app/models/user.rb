class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy

  accepts_nested_attributes_for :authentications

  validates_length_of :password,
                      minimum: 3,
                      message: "password must be at least 3 characters long",
                      if: :password
  validates_confirmation_of :password,
                            message: "should match confirmation",
                            if: :password
  validates :email, uniqueness: true
  validates :email, presence: true
  validates_format_of :email,
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                      on: :create,
                      message: "example@gmail.org"

end
