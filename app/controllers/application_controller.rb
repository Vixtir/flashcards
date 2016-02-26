class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def not_authenticated
    redirect_to login_path
    flash[:info] = "Please login or register!!!"
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def set_locale
    if current_user
      I18n.locale = current_user.language
    elsif I18n.locale = params[:locale]
    else
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end
end
