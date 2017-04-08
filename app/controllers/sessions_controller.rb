class SessionsController < ApplicationController
  layout false
  skip_before_action :require_login, only: [:new, :create]

  def new
    flash.now.alert = warden.message if warden.message.present?
  end

  def create
    warden.authenticate!
    redirect_to root_url, notice: 'Logged In!'
  end

  def destroy
    warden.logout
    redirect_to login_url, notice: 'logged out!'
  end

end
