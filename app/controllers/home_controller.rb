class HomeController < ApplicationController
  before_action :require_login
  def index
    @user = current_user  
    @card = @user.cards.need_check.rand_word.first
  end
end
