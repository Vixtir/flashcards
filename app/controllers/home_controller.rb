class HomeController < ApplicationController
  before_action :require_login
  before_action :set_card, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.json { render json: @card }
    end
  end

  def check
    cur_card = Card.find(params[:id])
    answer = params[:answer]
    @time = params[:time].to_i
    s = Supermemo.new(cur_card, @time)
    grade = s.grade(answer, @time)
    s.update_card(cur_card.i, cur_card.ef, answer, @time)
    set_card
    if grade == 5
      respond_to do |format|
        msg = { status: :ok , message: I18n.t('flash.card.right'), card: @card }
        format.json { render json: msg }
      end
    elsif grade == 4
      respond_to do |format|
        msg = { status: :ok , message: I18n.t('flash.card.error'), card: @card }
        format.json { render json: msg }
      end
    else
      respond_to do |format|
        msg = { status: :ok , message: I18n.t('flash.card.wrong'), card: @card }
        format.json { render json: msg }
      end
    end
  end

  private

    def set_card
      if current_user.decks.active.any?
        @deck = current_user.decks.active.first
        @card = @deck.cards.need_check.rand_word.first
      else
        @card = current_user.cards.need_check.rand_word.first
      end
    end

end

