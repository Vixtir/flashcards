# require 'levenshtein'

class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  mount_uploader :picture, PictureUploader

  scope :rand_word, -> { order("RANDOM()").limit(1) }
  scope :need_check, -> { where("review_date <= ?", Time.zone.now) }

  before_validation :set_review_date, on: [:create]
  before_save :downcase_translate

  validate  :equal_text

  validates :original_text,
            :translated_text,
            :review_date,
            :user_id,
            :deck_id,
            presence: true
  validates :translated_text, format: { with: /\A[а-яА-Я]+\z/,
                                        message: "Только на кириллице" }

  def equal_text
    if !original_text.nil? && !translated_text.nil?
      unless original_text.casecmp(translated_text)
        errors.add(:original_text, "Оригинал не может быть равен переводу")
        errors.add(:translated_text, "Перевод не может быть равен оригиналу")
      end
    end
  end

  def downcase_translate
    self.translated_text = translated_text.mb_chars.downcase.to_s
  end

  def set_review_date
    self.review_date = Time.zone.now
  end

  def add_review_date
    update_attribute(:review_date, Time.zone.now + 1.day)
  end
end
