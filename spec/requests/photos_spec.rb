require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  before { login_as(FactoryBot.create(:user, :admin)) }
  after { Warden.test_reset! }

  describe 'GET /photos' do
    let(:make_request) { get photos_path }

    let!(:photo1) { create(:photo) }
    let!(:photo2) { create(:photo) }

    it 'should list all photos' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      for photo in [photo1, photo2] do
        expect(body).to include(photo.product.product_code)
        expect(body).to include(photo.variety.variety_code)
        expect(body).to include(photo.place.name)
        expect(body).to include(photo.user.username)
      end
    end
  end

  describe 'GET /photos/:id' do
    let(:make_request) { get photo_path(photo1.id) }

    let!(:photo1) { create(:photo) }
    let!(:photo2) { create(:photo) }

    it 'should show photo' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
        expect(body).to include(photo1.product.product_code)
        expect(body).to include(photo1.variety.variety_code)
        expect(body).to include(photo1.place.name)
        expect(body).to include(photo1.user.username)
    end

    it 'should not show other photos' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      all_info = body.include?(photo2.product.product_code) &&
                 body.include?(photo2.variety.variety_code) &&
                 body.include?(photo2.place.name) &&
                 body.include?(photo2.user.username)
      expect(all_info).not_to be(true)
    end
  end

  xdescribe 'POST /photos' do # TODO: Fix after migration to active storage
    let(:make_request) { post photos_path, params: { photo: photo_params } }

    let(:product) { create(:product) }
    let(:variety) { create(:variety) }
    let(:place) { create(:place) }
    let(:user) { create(:user) }

    let!(:photo) { build(:photo) }
    let!(:photo_params) do
      {
        path: photo.path,
        variety_id: variety.id,
        place_id: place.id,
        date: DateTime.now,
        age: '6',
      }
    end

    describe 'when success' do
      it 'should create photo' do
        expect { make_request }.to change { Photo.count }.by(1)
      end

      it 'should redirect to photo' do
        make_request
        expect(response).to redirect_to(photo_path Photo.last.id)
      end
    end

    describe 'when fail' do
      it 'should not save without photo_code' do
        photo_params[:product_id] = ''
        expect { make_request }.to change { Photo.count }.by(0)
      end
    end
  end

  xdescribe 'PATCH /photos/:id' do # TODO: Fix after migration to active storage
    let(:make_request) { patch photo_path(photo.id), params: { photo: photo_params } }

    let(:product) { create(:product) }
    let(:variety) { create(:variety) }
    let(:place) { create(:place) }
    let(:user) { create(:user) }

    let!(:photo) { create(:photo) }
    let!(:update) { build(:photo) }
    let!(:photo_params) do
      {
        path: update.path,
        variety_id: variety.id,
        place_id: place.id,
        date: DateTime.now,
        age: '6',
      }
    end

    describe 'when success' do
      it 'should update photo' do
        expect { make_request }.to change { photo.reload.attributes }
      end

      it 'should redirect to photo' do
        make_request
        expect(response).to redirect_to(photo_path photo.id)
      end
    end

    describe 'when fail' do
      it 'should not save without name' do
        photo_params[:photo_code] = ''
        expect { make_request }.not_to change { photo.reload.attributes }
      end
    end
  end

  describe 'DELETE /photos/:id' do
    let(:make_request) { delete photo_path(photo.id) }

    let!(:photo) { create(:photo) }

    it 'should delete photo' do
      expect { make_request }.to change { Photo.count }.by(-1)
    end

    it 'should redirect to photos' do
      make_request
      expect(response).to redirect_to(photos_path)
    end
  end
end
