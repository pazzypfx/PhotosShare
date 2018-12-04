class GalleryController < ApplicationController
  skip_load_and_authorize_resource
  layout 'gallery'
  before_action :set_variables, only: [:index]

  def index
    render(file: 'public/404.html', status: :not_found, :layout => false) unless get_params
    @photos = Photo.find_all(@product, @variety, @place).page(params[:page])
    @products = Product.pluck('name, product_code')
    @varieties = @product.varieties.pluck('name, variety_code') if defined?(@product) && !@product.blank?
    @places = Place.pluck('name, place_code')
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
    exists
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
    true
  end

  def check_param(name)
    return 1 if Product.exists?(product_code: name)
    return 2 if Variety.exists?(variety_code: name)
    return 3 if Place.exists?(place_code: name)
    0
  end

end
