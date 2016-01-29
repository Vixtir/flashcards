class UserSessionsController < ApplicationController
  skip_before_action :require_login, expect: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(root_path)
      flash[:success] = "Login succefull"
    else
      flash.now[:warning] = "Login failed"
      render "new"
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: "Logget out!")
  end
end
