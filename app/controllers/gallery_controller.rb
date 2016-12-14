class GalleryController < ApplicationController

  def index
    @photos = Photo.all
    @products = Product.all
    @varieties = Variety.all
    @places = Place.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

end
