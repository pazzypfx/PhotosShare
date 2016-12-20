class GalleryController < ApplicationController
before_action :set_variables, only: [:index]

  def index
    if(!get_params)
      render(:file => 'public/404.html', :status => :not_found, :layout => false)
    end
    @products = Product.all.pluck('product_code, name')
    @varieties = @product.varieties.pluck('variety_code, name') if defined?(@product) && !@product.blank?
    @places = Place.all.pluck('name, place_code')
    @photos = Photo.find_all(@product, @variety, @place)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private
    # Set the variables if defined in url or to empty if not
    def set_variables
      # Set selected product, variety, and place to nil
      @product = nil
      @product_code = ''
      @variety = nil
      @variety_code = ''
      @place = nil
      @place_code = ''

      # Set products, varieties, places to empty
      @products = []
      @varieties = []
      @places = []
      @photos = []
    end

    def get_params
      exists = true
      exists &= set_param(params[:name1]) if params[:name1].present?
      exists &= set_param(params[:name2]) if params[:name2].present?
      exists &= set_param(params[:name3]) if params[:name3].present?
      return exists
    end

    def set_param(name)
      case check_param(name)
        when 1
          @product = Product.find_by_name(name)
          @product_code = @product.product_code
        when 2
          @variety = Variety.find_by_name(name) if Variety.exists?({name: name})
          @variety_code = @variety.variety_code
        when 3
          @place = Place.find_by_name(name) if Place.exists?({name: name})
          @place_code = @place.place_code
        else
          return false
      end
      return true
    end

    def check_param(name)
      return 1 if Product.exists?({name: name})
      return 2 if Variety.exists?({name: name})
      return 3 if Place.exists? ({name: name})
      return 0
    end

end