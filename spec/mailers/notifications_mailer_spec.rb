require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe 'user pending cards notifications' do
    let(:user) { create(:user, email: "vixtir90@gmail.com") }
    let(:mail) { NotificationsMailer.pending_cards(user) }

    it 'subject' do
      expect(mail.subject).to eq('Проверь свои знания')
    end

    it 'mail to' do
      expect(mail.to).to eq([user.email])
    end

    it 'mail from' do
      expect(mail.from).to eql(['paulflashcards@gmail.com'])
    end
  end
end
