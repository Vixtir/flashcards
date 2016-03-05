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
      flash[:success] = t('flash.card.create')
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
      flash[:success] = t('flash.card.edit')
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
    @s = Supermemo.new(@card)
    @grade = @s.grade(@answer)
    # if @card.check_word(@answer)
    if @grade == 5
      flash[:success] = t('flash.card.right')
      redirect_to root_path
    elsif @grade == 4
      flash.now[:success] = t('flash.card.error')
      render "_right_answer"
    else
      flash.now[:danger] = t('flash.card.wrong')
      render "home/index"
    end
    @s.check_word(@card.i, @card.ef, @answer)
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :picture, :deck_id, :bucket, :i, :ef)
  end

  def correct_user_card
    unless current_card.user == current_user
      flash[:danger] = t('flash.card.wrong_user')
      redirect_to cards_path
    end
  end

  def current_card
    @card = Card.find(params[:id])
  end

end
