require 'levenshtein'

class Supermemo
  def initialize(card, time)
    @card = card
    @time = time
  end

  def grade(answer, time)
    [(5 - lev_dist(answer) - (@card.attempt - 1)) - time / 20, 0].max
  end

  def next_ef(ef, grade)
    @card.ef = [ef + (0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02)), 1.3].max
  end

  def next_i(i, grade)
    grade < 3 ? 1 : i + 1
  end

  def add_day(i, ef)
    if i < 3
        i == 1 ? 1.day : 6.day
    else
        ((i - 1) * ef).round.day
    end    
  end

  def interval(i, ef, grade)
    grade < 3 ? 0 : add_day(i, ef)
  end

  def next_interval(i, ef, grade)
    @card.review_date = @card.review_date + interval(i, ef, grade)
  end

  def update_card(i, ef, answer, time)
    if lev_dist(answer) <= 1
      next_interval(i, ef, grade(answer, time))
      @card.ef = next_ef(ef, grade(answer, time))
      @card.i = next_i(i, grade(answer, time))
      @card.attempt = 1
    else
      @card.attempt += 1
    end
    @card.save
  end

  def lev_dist(answer)
    Levenshtein.distance(@card.translated_text, answer.mb_chars.downcase.to_s)
  end
end
