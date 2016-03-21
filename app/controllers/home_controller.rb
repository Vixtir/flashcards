class HomeController < ApplicationController
  before_action :require_login
  before_action :set_card, only: [:index]

  def index
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

  def supermemo
    Supermemo.new(card_for_check, params[:time].to_i)
  end

  def update_card
    supermemo.update_card(card_for_check.i, card_for_check.ef, params[:answer], params[:time].to_i)
  end

  def card_grade
    supermemo.grade(params[:answer], params[:time].to_i)
  end

  def message(alert)
    respond_to do |format|
      msg = { status: :ok, message: alert, card: @card }
      format.json { render json: msg }
    end
  end

  def make_response
    set_card
    if card_grade == 5
      message(I18n.t('flash.card.right'))
    elsif card_grade == 4
      message(I18n.t('flash.card.error'))
    else
      message(I18n.t('flash.card.wrong'))
    end
  end
end
