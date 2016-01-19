class CardsController < ApplicationController
  before_action :current_card, only: [:show,:edit,:update,:destroy]

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to cards_path
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @cards = Card.all
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render 'edit'
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
 
    def current_card
      @card = Card.find(params[:id])
    end
end
