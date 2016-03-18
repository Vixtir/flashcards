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
    update_card
    make_response
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

  def card_for_check
    Card.find(params[:id])
  end

  def user_answer
    params[:answer]
  end

  def question_time
    params[:time].to_i
  end

  def supermemo
    Supermemo.new(card_for_check, question_time)
  end

  def update_card
    supermemo.update_card(card_for_check.i, card_for_check.ef, user_answer, question_time)
  end

  def card_grade
    supermemo.grade(user_answer, question_time)
  end

  def make_response
    set_card
    if card_grade == 5
      respond_to do |format|
        msg = { status: :ok, message: I18n.t('flash.card.right'), card: @card }
        format.json { render json: msg }
      end
    elsif card_grade == 4
      respond_to do |format|
        msg = { status: :ok, message: I18n.t('flash.card.error'), card: @card }
        format.json { render json: msg }
      end
    else
      respond_to do |format|
        msg = { status: :ok, message: I18n.t('flash.card.wrong'), card: @card }
        format.json { render json: msg }
      end
    end
  end
end
