class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to root_path
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
  end

  def destroy
  end

  private
    def card_params
      params.require(:card).permit(:original_text,:translated_text)
    end
end
