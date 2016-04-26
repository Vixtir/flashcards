class Dashboard::CardsController < ApplicationController
  before_action :current_card, only: [:show,:edit,:update,:destroy]
  before_action :correct_user_card, only: [:edit]
  before_action :require_login

  def new
    @card = current_user.cards.build
    @decks = current_user.decks
  end

  def create
    @card = current_user.cards.create(card_params)
    @card.deck = Deck.find(params[:card][:deck_id])
    if @card.save
      flash[:success] = t('flash.card.create')
      redirect_to dashboard_cards_path
    else
      render "new"
    end
  end

  def show; end

  def index
    @cards = current_user.cards
  end

  def edit; end

  def update
    if @card.update(card_params)
      redirect_to dashboard_cards_path
      flash[:success] = t('flash.card.edit')
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to dashboard_cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :picture, :deck_id, :bucket, :attempt)
  end

  def correct_user_card
    unless current_card.user == current_user
      flash[:danger] = t('flash.card.wrong_user')
      redirect_to dashboard_cards_path
    end
  end

  def current_card
    @card = Card.find(params[:id])
  end

end
