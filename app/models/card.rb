class Card < ActiveRecord::Base
  scope :rand_word, -> { order("RANDOM()").limit(1) }
  scope :need_check, -> { where("review_date <= ?", Time.zone.now) }

  before_validation :set_review_date, on: [:create]
  before_save :downcase_translate

  validates :original_text, :translated_text, :review_date, presence: true
  validates :translated_text, format: { with: /\A[а-яА-Я]+\z/,
                                        message: "Только на кириллице" }
  validate  :equal_text

  def equal_text
    if self.original_text.downcase == self.translated_text.downcase
      errors.add(:original_text, "Оригинал не может быть равен переводу")
      errors.add(:translated_text, "Перевод не может быть равен оригиналу")
    end
  end

  def downcase_translate
    self.translated_text = translated_text.mb_chars.downcase
  end

  def set_review_date
    self.review_date = Time.zone.today
  end

  def add_review_date
    update_attribute(:review_date, Time.zone.now + 3.day)
  end

  def check_word(question, answer)
    answer = answer.downcase
    if question == answer
      add_review_date
    end
  end
end
