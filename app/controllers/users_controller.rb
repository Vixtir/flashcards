class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :external_user, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path
      flash[:success] = t('flash.user.create') 
    else
      render action: "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    external_user
    if @user.update_attributes(user_params)
      redirect_to(root_path, notice: t('flash.user.edit'))
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
