class CardsController < ApplicationController
  before_action :current_card, only: [:show,:edit,:update,:destroy]
  before_action :correct_user_card, only: [:edit]
  before_action :require_login

  def new
    @user = current_user
    @card = @user.cards.build
  end

  def create
    @user = current_user
    @card = @user.cards.create(card_params)

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
    @user = current_user
    @cards = @user.cards
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
    
    if @card.check_word(params[:answer])
      flash[:success] = "Right"
      redirect_to root_path
    else
      flash[:danger] = "Wrong"
      render "home/index"
    end
  end

  private

    def card_params
      params.require(:card).permit(:original_text,:translated_text)
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
end
