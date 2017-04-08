class ApplicationController < ActionController::Base
  layout 'admin'
  protect_from_forgery with: :exception
  before_action :require_login

  private

    def current_user
      if user_signed_in?
        warden.user
      end
    end
    helper_method :current_user

    def user_signed_in?
      warden.authenticated?
    end
    helper_method :user_signed_in?

    def require_login
      unless current_user
        redirect_to login_path
      end
    end
    helper_method :require_login

    def warden
      env['warden']
    end
end
