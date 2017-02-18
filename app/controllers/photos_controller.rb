class PhotosController < ApplicationController
  before_action :get_list_info,  except: [:index, :show]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_photo_params, except:  [:index, :show]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    # todo: get current user to affect to the added photo
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

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
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

    def get_list_info
      #todo: use product_code, variety_code, and place_code to hide the ID from the user
      @products = Product.all.pluck('name, id')
      @varieties = Variety.all.pluck('name, id')
      @places = Place.all.pluck('name, id')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:path, :variety_id, :place_id, :date, :published, :product)
    end

end
