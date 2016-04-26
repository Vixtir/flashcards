class Home::HomeController < ApplicationController
  before_action :require_login
  layout 'home'

  def index; end
end
