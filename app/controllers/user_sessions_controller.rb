class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(root_path)
      flash[:success] = t('flash.session.login')
    else
      flash.now[:warning] = t('flash.session.wrong_login')
      render "new"
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: t('flash.session.logout'))
  end
end
