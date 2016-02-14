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
    update_attribute(:review_date, add_time(bucket))
  end

  def add_time(bucket)
    case bucket
    when 1
      Time.zone.now + 12.hour
    when 2
      Time.zone.now + 3.day
    when 3
      Time.zone.now + 7.day
    when 4
      Time.zone.now + 2.week
    when 5
      Time.zone.now + 4.week
    end
  end

  def reset_attempt
    update_attribute(:attempt, 0)
  end

  def add_attempt
    update_attribute(:attempt, attempt + 1)
  end

  def up_bucket_level
    if bucket < 5 
      update_attribute(:bucket, bucket + 1)
    end
  end

  def down_bucket_level
    if bucket > 1
      update_attribute(:bucket, bucket - 1)
    end
  end

  def check_attempt_count
    if attempt == 2
      down_bucket_level
      reset_attempt
    else
      add_attempt
    end
  end

  def check_word(answer)
    if translated_text == answer.mb_chars.downcase.to_s
      add_review_date
      up_bucket_level
      reset_attempt
    else
      check_attempt_count
      false
    end
  end
end
