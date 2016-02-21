class NotificationsMailer < ApplicationMailer
  default from: 'paulflashcards@gmail.com'

  def pending_cards(user)
    @user = user
    email = mail to: @user.email, subject: "You have unchecked card"
  end
end
