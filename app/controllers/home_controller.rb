class HomeController < ApplicationController
  before_action :current_card, only: :index
  def index    
    @card = current_card
  end
  
  private

    def current_card
      card = Card.need_check.rand_word.first
    end
end
