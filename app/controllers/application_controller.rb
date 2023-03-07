class ApplicationController < ActionController::Base
  add_flash_types :danger, :success, :warning

  before_action :require_login

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_back fallback_location: root_path
  end

  def alert_login
    return if logged_in?

    @user = User.new
    flash.now[:warning] = t('defaults.message.require_login')
    render 'user_sessions/new'
  end
end
