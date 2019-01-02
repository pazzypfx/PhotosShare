# Controller for Products management
class ProductsController < ApplicationController
  before_action :init_product, only: %i[show edit update destroy]
  skip_load_and_authorize_resource only: :varieties
  skip_before_action :authorize_admin_manager, only: :varieties

  # GET /products
  # GET /products.json
  def index; end

  # GET /products/1
  # GET /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def varieties
    @varieties = Product
                  .find_by(product_code: params[:code])
                  .varieties
                  .pluck('name, variety_code')

    if @varieties.present?
      render json: @varieties.to_json, status: :ok
    else
      render status: :no_content
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def init_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :product_code)
  end
end
