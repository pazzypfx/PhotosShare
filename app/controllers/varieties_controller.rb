# Controller for Varieties management
class VarietiesController < ApplicationController
  before_action :init_variety, only: %i[show edit update destroy]
  before_action :init_products, execpt: :index

  # GET /varieties
  # GET /varieties.json
  def index
    @varieties = Variety.accessible_by(current_ability)
    @varieties = @varieties.where(product_id: params[:product]) if params[:product]
  end

  # GET /varieties/new
  def new
    @variety = Variety.new
  end

  # GET /varieties/1
  # GET /varieties/1.json
  def show; end

  # GET /varieties/1/edit
  def edit; end

  # POST /varieties
  # POST /varieties.json
  def create
    @variety = Variety.new(variety_params)
    @product_id = params[:variety][:product_id]

    respond_to do |format|
      if @variety.save
        format.html { redirect_to @variety, notice: 'Variety was successfully created.' }
        format.json { render :show, status: :created, location: @variety }
      else
        format.html { render :new }
        format.json { render json: @variety.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /varieties/1
  # PATCH/PUT /varieties/1.json
  def update
    respond_to do |format|
      if @variety.update(variety_params)
        format.html { redirect_to @variety, notice: 'Variety was successfully updated.' }
        format.json { render :show, status: :ok, location: @variety }
      else
        format.html { render :edit }
        format.json { render json: @variety.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /varieties/1
  # DELETE /varieties/1.json
  def destroy
    @variety.destroy
    respond_to do |format|
      format.html { redirect_to varieties_url, notice: 'Variety was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def init_variety
    @variety = Variety.find(params[:id])
    @product = @variety.product
    @product_id = @product.id
  end

  def init_products
    @products = Product.all.pluck('name, id')
  end

  def variety_params
    params.require(:variety).permit(:name, :variety_code, :product_id)
  end
end
