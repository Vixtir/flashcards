require 'levenshtein'

class Supermemo
  def initialize(card)
    @card = card
  end

  def grade(answer)
    return 5 if lev_dist(answer) == 0 && @card.attempt == 1
    return 4 if lev_dist(answer) == 1 && @card.attempt == 1

    case @card.attempt
    when 2 then 3
    when 3 then 2
    when 4 then 1
    else 0
    end

  end

  def next_ef(ef, grade)
    @card.ef = [ef + (0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02)), 1.3].max
  end

  def next_i(i, grade)
    if grade < 3
      return 1
    else
      return i + 1
    end
  end

 def interval(i, ef, grade)
   return 0 if grade < 3

   case i
   when 1 then 1.day
   when 2 then 6.day
   else ((i - 1) * ef).round.day
   end
  end

  def next_interval(i, ef, grade)
    @card.review_date = @card.review_date + interval(i, ef, grade)
  end

  def check_word(i, ef, answer)
    if lev_dist(answer) <= 1
      next_interval(i, ef, grade(answer))
      @card.ef = next_ef(ef, grade(answer))
      @card.i = next_i(i, grade(answer))
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
