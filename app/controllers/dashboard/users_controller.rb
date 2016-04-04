class Dashboard::UsersController < ApplicationController
  before_action :require_login
  before_action :external_user, only: [:edit]

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    external_user
    if @user.update_attributes(user_params)
      redirect_to(dashboard_root_path, notice: t('flash.user.edit'))
    else
      render :action => "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :language)
  end

  def external_user
    @user = User.find(params[:id])
    if @user.external?
      redirect_to root_path
    end
  end
end
