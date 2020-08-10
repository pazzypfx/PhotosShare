require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before { login_as(FactoryBot.create(:user, %i[admin manager].sample)) }
  after { Warden.test_reset! }

  describe 'GET /products' do
    let(:make_request) { get products_path }

    let!(:product1) { create(:product) }
    let!(:product2) { create(:product) }

    it 'should list all products' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      for product in [product1, product2] do
        expect(body).to include(product.name)
        expect(body).to include(product.product_code)
      end
    end
  end

  describe 'GET /products/:id' do
    let(:make_request) { get product_path(product1.id) }

    let!(:product1) { create(:product) }
    let!(:product2) { create(:product) }

    it 'should show product' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      expect(body).to include(product1.name)
      expect(body).to include(product1.product_code)
    end

    it 'should not show other products' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      all_info = body.include?(product2.name) &&
                 body.include?(product2.product_code)
      expect(all_info).not_to be(true)
    end
  end

  describe 'POST /products' do
    let(:make_request) { post products_path, params: { product: product_params } }

    let!(:product) { build(:product) }
    let!(:product_params) do
      {
        name: product.name,
        product_code: product.product_code,
      }
    end

    describe 'when success' do
      it 'should create product' do
        expect { make_request }.to change { Product.count }.by(1)
      end

      it 'should redirect to product' do
        make_request
        expect(response).to redirect_to(product_path Product.last.id)
      end
    end

    describe 'when fail' do
      it 'should not save without product_code' do
        product_params[:product_code] = ''
        expect { make_request }.to change { Product.count }.by(0)
      end
    end
  end

  describe 'PATCH /products/:id' do
    let(:make_request) { patch product_path(product.id), params: { product: product_params } }

    let!(:product) { create(:product) }
    let!(:update) { build(:product) }
    let!(:product_params) do
      {
        name: update.name,
        product_code: update.product_code,
      }
    end

    describe 'when success' do
      it 'should update product' do
        expect { make_request }.to change { product.reload.attributes }
        expect(product.name).to eq(update.name)
        expect(product.product_code).to eq(update.product_code)
      end

      it 'should redirect to product' do
        make_request
        expect(response).to redirect_to(product_path product.id)
      end
    end

    describe 'when fail' do
      it 'should not save without name' do
        product_params[:product_code] = ''
        make_request
        product.reload.attributes

        all_info = product.name == update.name &&
                   product.product_code == update.product_code
        expect(all_info).not_to be(true)
      end
    end
  end

  describe 'DELETE /products/:id' do
    let(:make_request) { delete product_path(product.id) }

    let!(:product) { create(:product) }

    it 'should delete product' do
      expect { make_request }.to change { Product.count }.by(-1)
    end

    it 'should redirect to products' do
      make_request
      expect(response).to redirect_to(products_path)
    end
  end
end
