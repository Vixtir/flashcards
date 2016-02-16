class CardsController < ApplicationController
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
      flash[:success] = "Карточка успешно создана"
      redirect_to cards_path
    else
      render "new"
    end
  end

  def show
  end

  def index
    @cards = current_user.cards
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  def check
    @card = Card.find(params[:card][:id])
    @answer = params[:answer]
    if @card.check_word(params[:answer])
      if lev_dist == 0
        flash[:success] = "Правильно"
        redirect_to root_path
      else
        flash.now[:success] = "Ответ верный, но ты допустил ошибку в слове"
        render "_right_answer"
      end
    else
      flash.now[:danger] = "Неправильно"
      render "home/index"
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :picture, :deck_id, :bucket, :attempt)
  end

  def correct_user_card
    unless current_card.user == current_user
      flash[:danger] = "U cant edit not ur cards"
      redirect_to cards_path
    end
  end

  def current_card
    @card = Card.find(params[:id])
  end

  def lev_dist
    @card.lev_dist(params[:answer])
  end
end
