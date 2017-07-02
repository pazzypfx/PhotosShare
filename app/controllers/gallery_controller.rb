class GalleryController < ApplicationController
  layout 'gallery'
  layout 'application', only: [:new]
  before_action :set_variables, only: [:index]
  before_action :get_lists_info,  only: [:new, :create]
  before_action :set_photo_params, except:  [:new, :create]

  WillPaginate.per_page = 6

  def index
    if(!get_params)
      render(:file => 'public/404.html', :status => :not_found, :layout => false)
    end
    @photos = Photo.find_all(@product, @variety, @place).paginate(page: params[:page], per_page: 6)
    @photos = @photos.where(published: true)
    @products = Product.all.pluck('name, product_code')
    @varieties = @product.varieties.pluck('name, variety_code') if defined?(@product) && !@product.blank?
    @places = Place.all.pluck('name, place_code')
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
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
          @product = Product.find_by_product_code(name)
          @product_code = @product.product_code
        when 2
          @variety = Variety.find_by_variety_code(name)
          @variety_code = @variety.variety_code
        when 3
          @place = Place.find_by_place_code(name)
          @place_code = @place.place_code
        else
          return false
      end
      return true
    end

    def check_param(name)
      return 1 if Product.exists?({product_code: name})
      return 2 if Variety.exists?({variety_code: name})
      return 3 if Place.exists? ({place_code: name})
      return 0
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:path, :variety_id, :place_id, :date, :published, :product)
    end

end
