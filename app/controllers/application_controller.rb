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

    def set_photo_params
      if !@photo.blank?
        @product = @photo.product
        @product_id = @product.id
        @varieties = @product.varieties.pluck('name, id')
        @variety_id = @photo.variety.id
        @place_code = @photo.place.place_code
        return
      end
      if !params[:product].blank?
        @product = Product.find_by_id(params[:product])
        @product_id = @product.id unless @product.blank?
        @varieties = @product.varieties.pluck('name, id') unless @product.blank?
      end
      if !params[:photo].blank?
        @variety_id = params[:photo][:variety_id]
        @place_code = params[:photo][:place_id]
      end
    end

    def get_lists_info
      #todo: use product_code, variety_code, and place_code to hide the ID from the user
      @products = Product.all.pluck('name, id')
      @varieties = Variety.all.pluck('name, id')
      @places = Place.all.pluck('name, id')
    end

end
