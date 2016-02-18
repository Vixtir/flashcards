class NotificationsMailer < ApplicationMailer
  default from: 'paulflashcards@gmail.com'

  def pending_cards(user)
    @user = user
    @cards = @user.cards.need_check.count
    @url = 'https://tranquil-cove-21486.herokuapp.com/login'
    mail(to: @user.email, subject: 'You have unchecked card')
  end
end
