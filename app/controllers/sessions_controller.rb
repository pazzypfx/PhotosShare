# Controller for managing logins and log-outs
class SessionsController < ApplicationController
  skip_load_and_authorize_resource
  layout false
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :authorize_admin_manager

  def new
    flash.now.alert = warden.message if warden.message.present?
  end

  def create
    warden.authenticate!
    redirect_to photos_url and return unless current_user.agent?
    redirect_to root_url, notice: 'Logged In!'
  end

  def destroy
    warden.logout
    redirect_to login_url, notice: 'logged out!'
  end
end
