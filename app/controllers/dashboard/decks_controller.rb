class Dashboard::DecksController < ApplicationController
  before_action :require_login

  def new
    @deck = current_user.decks.build
  end

  def create
    @deck = current_user.decks.create(decks_params)

    if @deck.save
      redirect_to dashboard_root_path
      flash[:success] = "A new deck has been created"
    else
      render "new"
    end
  end

  def index
    @decks = current_user.decks
  end

  def activate
    @deck = Deck.find(params[:id])
    @deck.activate
    @deck.save!
    redirect_to dashboard_decks_path
  end

  private

  def decks_params
    params.require(:deck).permit(:title, :status)
  end
end
