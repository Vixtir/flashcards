class Dashboard::UserSessionsController < ApplicationController
  def destroy
    logout
    redirect_to(home_root_path, notice: t('flash.session.logout'))
  end
end
