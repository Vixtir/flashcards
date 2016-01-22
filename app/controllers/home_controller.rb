class HomeController < ApplicationController
  def index
    @card = Card.need_check.rand_word.first
  end
end
