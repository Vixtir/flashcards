class NotificationsMailer < ApplicationMailer
default from: 'notifications@example.com'

  def pending_cards(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
