# Main controller used to check users and fetch needed data
class ApplicationController < ActionController::Base
  load_and_authorize_resource
  layout 'admin'
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :authorize_admin_manager

  private

  def current_user
    warden.user if user_signed_in?
  end
  helper_method :current_user

  def user_signed_in?
    warden.authenticated?
  end
  helper_method :user_signed_in?

  def require_login
    redirect_to login_path unless current_user
  end
  helper_method :require_login

  def warden
    request.env['warden']
  end

  def authorize_admin_manager
    return true if current_user.admin? || current_user.manager?
    flash[:error] = 'unauthorized access'
    redirect_back fallback_location: root_path
    false
  end
  helper_method :authorize_admin_manager

  def set_photo_params
    if @photo.present?
      @product = @photo.product
      @product_id = @product.id
      @varieties = @product.varieties.pluck('name, id')
      @variety_id = @photo.variety.id
      @place_code = @photo.place.place_code
      return
    end
    if params[:product].present?
      @product = Product.find_by(id: params[:product])
      @product_id = @product.id if @product.present?
      @varieties = @product.varieties.pluck('name, id') if @product.present?
    end
    return if params[:photo].blank?
    @variety_id = params[:photo][:variety_id]
    @place_code = params[:photo][:place_id]
  end

  def lists_info
    # TODO: use product_code, variety_code, and place_code to hide the ID from the user
    @products = Product.all.pluck('name, id')
    @varieties = Variety.all.pluck('name, id')
    @places = Place.all.pluck('name, id')
    @ages = Photo.ages
  end
end
