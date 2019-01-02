# Controller used to show/sort/filter/create Photos by agents
class GalleryController < ApplicationController
  skip_load_and_authorize_resource
  layout 'gallery', only: %i[index show]
  layout 'agent', only: %i[new create]
  before_action :init_variables, only: %i[index new create]
  before_action :translate_codes, only: :create
  skip_before_action :authorize_admin_manager

  def index
    unless check_params
      render(file: 'public/404.html', status: :not_found, layout: false)
    end
    @photos = Photo.find_all(@product, @variety, @place)
                   .filter_by_ages(@age1, @age2)
                   .page(params[:page])
    return unless defined?(@product) && @product.present?
    @varieties = @product.varieties.pluck('name, variety_code')
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end
  
  def create
    @photo = Photo.new(photo_params)
    @photo.variety = @variety
    @photo.place = @place
    # TODO: get current user to affect to the added photo
    @photo.user = User.find(1)
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
  def init_variables
    # Set selected product, variety, and place to nil
    @product = nil
    @product_code = ''
    @variety = nil
    @variety_code = ''
    @place = nil
    @place_code = ''
    @age1 = nil
    @age2 = nil

    # Set products, varieties, places to empty
    @products = Product.pluck('name, product_code')
    @varieties = []
    @places = Place.pluck('name, place_code')
    @photos = []
    @ages = Photo.ages
  end

  def check_params
    exists = true
    exists &= init_param(params[:product]) if params[:product].present?
    exists &= init_param(params[:variety]) if params[:variety].present?
    exists &= init_param(params[:place]) if params[:place].present?
    init_dates(params[:age]) if params[:age].present?
    exists
  end

  def init_param(name)
    case check_param(name)
    when 1
      @product = Product.find_by(product_code: name)
      @product_code = @product.product_code
    when 2
      @variety = Variety.find_by(variety_code: name)
      @variety_code = @variety.variety_code
    when 3
      @place = Place.find_by(place_code: name)
      @place_code = @place.place_code
    else
      return false
    end
    true
  end

  def check_param(name)
    return 1 if Product.exists?(product_code: name)
    return 2 if Variety.exists?(variety_code: name)
    return 3 if Place.exists?(place_code: name)
    0
  end

  def init_dates(param)
    ages = param.split(',').map(&:to_i).sort
    return if ages.sum.zero?
    @age1, @age2 = ages
  end

  def photo_params
    params.require(:photo).permit(:path, :variety_id, :place_id, :date,
                                  :published, :product, :age)
  end

  def translate_codes
    @place = Place.find_by(place_code: params[:photo][:place_code])
    @place_code = @place.place_code
    @variety = Variety.find_by(variety_code: params[:photo][:variety_code])
    @variety_code = @variety.variety_code
    @varieties = @variety.product.varieties.pluck('name, variety_code')
    @product_id = @variety.product.product_code
  end
end
