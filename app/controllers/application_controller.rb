class ApplicationController < ActionController::Base
  add_flash_types :danger, :success, :warning

  before_action :require_login

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_back fallback_location: root_path
  end
end
