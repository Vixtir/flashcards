class Home::UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  layout 'home'
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to dashboard_root_path
      flash[:success] = t('flash.session.login')
    else
      flash.now[:warning] = t('flash.session.wrong_login')
      render "new"
    end
  end
end
