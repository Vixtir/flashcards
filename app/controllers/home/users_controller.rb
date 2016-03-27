class Home::UsersController < ApplicationController
  skip_before_action :require_login
  layout 'home'

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      auto_login(@user)
      redirect_to dashboard_root_path
      flash[:success] = t('flash.user.create')
    else
      render action: "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :language)
  end
end
