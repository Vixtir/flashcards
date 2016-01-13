class Card < ActiveRecord::Base
  before_validation :add_review_time
  
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true

  protected
    def add_review_time
      self.review_date = Date.today + 3.day
    end
end
