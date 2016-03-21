class HomeController < ApplicationController
  before_action :require_login

  def index
    if current_user.decks.active.any?
      @deck = current_user.decks.active.first
      @card = @deck.cards.need_check.rand_word.first
    else
      @card = current_user.cards.need_check.rand_word.first
    end
  end
end
