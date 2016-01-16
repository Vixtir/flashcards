class Card < ActiveRecord::Base
  before_validation :add_review_time
  
  validates :original_text, :translated_text, :review_date, presence: true
 
  validate  :equal_text
 
  def equal_text
    if self.original_text.downcase == self.translated_text.downcase
      errors.add(:original_text, "Оригинал не может быть равен переводу")
      errors.add(:translated_text, "Перевод не может быть равен оригиналу")
    end	
  end
  
  protected
    def add_review_time
      self.review_date = Date.today + 3.day
    end
end
