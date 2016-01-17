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
    if  params[:card][:translated_text] == params[:answer]
      flash[:success] = "Правильно"
      add_days
      redirect_to root_url 
    else
      flash.now[:danger] = "Не правильно, попробуй еще раз"
      render 'home/index'     
    end
  end

  private
    def card_params
      params.require(:card).permit(:original_text,:translated_text)
    end
 
    def current_card
      @card = Card.find(params[:id])
    end
    
    def add_days
      @card.add_review_date
    end
end
