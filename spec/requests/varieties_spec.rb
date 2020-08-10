require 'rails_helper'

RSpec.describe 'Varieties', type: :request do
  before { login_as(FactoryBot.create(:user, %i[admin manager].sample)) }
  after { Warden.test_reset! }

  describe 'GET /varieties' do
    let(:make_request) { get varieties_path }

    let!(:product) { create(:product) }
    let!(:variety1) { create(:variety, product: product) }
    let!(:variety2) { create(:variety, product: product) }

    it 'should list all varieties' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      for variety in [variety1, variety2] do
        expect(body).to include(product.product_code)
        expect(body).to include(variety.name)
        expect(body).to include(variety.variety_code)
      end
    end
  end

  describe 'GET /varieties/:id' do
    let(:make_request) { get variety_path(variety1.id) }

    let!(:product) { create(:product) }
    let!(:variety1) { create(:variety, product: product) }
    let!(:variety2) { create(:variety, product: product) }

    it 'should show variety' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      expect(body).to include(product.product_code)
      expect(body).to include(variety1.name)
      expect(body).to include(variety1.variety_code)
    end

    it 'should not show other varieties' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      all_info = body.include?(variety2.name) &&
                 body.include?(variety2.variety_code)
      expect(all_info).not_to be(true)
    end
  end

  describe 'POST /varieties' do
    let(:make_request) { post varieties_path, params: { variety: variety_params } }

    let!(:product) { create(:product) }
    let!(:variety) { build(:variety) }
    let!(:variety_params) do
      {
        name: variety.name,
        variety_code: variety.variety_code,
        product_id: product.id
      }
    end

    describe 'when success' do
      it 'should create variety' do
        expect { make_request }.to change { Variety.count }.by(1)
      end

      it 'should redirect to variety' do
        make_request
        expect(response).to redirect_to(variety_path Variety.last.id)
      end
    end

    describe 'when fail' do
      it 'should not save without variety_code' do
        variety_params[:variety_code] = ''
        expect { make_request }.to change { Variety.count }.by(0)
      end

      it 'should not save without variety_code' do
        variety_params[:product_id] = nil
        expect { make_request }.to change { Variety.count }.by(0)
      end
    end
  end

  describe 'PATCH /varieties/:id' do
    let(:make_request) { patch variety_path(variety.id), params: { variety: variety_params } }

    let!(:variety) { create(:variety) }
    let!(:update) { build(:variety) }
    let!(:variety_params) do
      {
        name: update.name,
        variety_code: update.variety_code,
      }
    end

    describe 'when success' do
      it 'should update variety' do
        expect { make_request }.to change { variety.reload.attributes }
        expect(variety.name).to eq(update.name)
        expect(variety.variety_code).to eq(update.variety_code)
      end

      it 'should redirect to variety' do
        make_request
        expect(response).to redirect_to(variety_path variety.id)
      end
    end

    describe 'when fail' do
      it 'should not save without name' do
        variety_params[:variety_code] = ''
        make_request
        variety.reload.attributes

        all_info = variety.name == update.name &&
                   variety.variety_code == update.variety_code
        expect(all_info).not_to be(true)
      end
    end
  end

  describe 'DELETE /varieties/:id' do
    let(:make_request) { delete variety_path(variety.id) }

    let!(:variety) { create(:variety) }

    it 'should delete variety' do
      expect { make_request }.to change { Variety.count }.by(-1)
    end

    it 'should redirect to varieties' do
      make_request
      expect(response).to redirect_to(varieties_path)
    end
  end
end
