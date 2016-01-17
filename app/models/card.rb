class Card < ActiveRecord::Base
  scope :rand_word, -> { order("RANDOM()").limit(1) }
  scope :need_check, lambda { where('review_date <= ?', Time.now) }
  
  before_validation :set_review_date
  
  validates :original_text, :translated_text, :review_date, presence: true
 
  validate  :equal_text
 
  def equal_text
    if self.original_text.downcase == self.translated_text.downcase
      errors.add(:original_text, "Оригинал не может быть равен переводу")
      errors.add(:translated_text, "Перевод не может быть равен оригиналу")
    end	
  end
  
  
  def set_review_date
    self.review_date = Date.today	
  end

  def add_review_date
    self.update_attribute(:review_date, Date.today + 3.day)
  end

end
