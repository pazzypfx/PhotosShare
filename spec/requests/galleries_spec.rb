require 'rails_helper'

RSpec.describe 'Galeries', type: :request do
  before { login_as(FactoryBot.create(:user, :agent)) }
  after { Warden.test_reset! }

  describe 'GET /galeries' do
    let(:make_request) { get root_path }

    let!(:photo1) { create(:photo) }
    let!(:photo2) { create(:photo) }

    it 'should list all galeries' do
      make_request

      expect(response).to be_successful

      for photo in [photo1, photo2] do
        expect(response.body).to include(encoded_image_name(photo.path.path))
      end
    end
  end

  describe 'GET /galeries/:id' do
    let(:make_request) { get "/gallery/show/#{photo1.id}" }

    let!(:photo1) { create(:photo) }
    let!(:photo2) { create(:photo) }

    it 'should show gallery' do
      make_request

      expect(response).to be_successful

      expect(response.body).to include(encoded_image_name(photo1.path.path))
    end

    it 'should not show other galeries' do
      make_request

      expect(response).to be_successful

      expect(response.body).not_to include(encoded_image_name(photo2.path.path))
    end
  end

  xdescribe 'POST /galeries' do # TODO: Fix after migration to active storage
    let(:make_request) { post '/gallery', params: { photo: photo_params } }

    let(:variety) { create(:variety) }
    let(:place) { create(:place) }
    let(:user) { create(:user) }

    let!(:photo) { build(:photo) }
    let!(:photo_params) do
      {
        path: photo.path,
        variety_code: variety.variety_code,
        place_code: place.place_code,
        date: DateTime.now,
        age: '6',
      }
    end

    describe 'when success' do
      it 'should create gallery' do
        expect { make_request }.to change { Photo.count }.by(1)
      end

      it 'should redirect to gallery' do
        make_request
        expect(response).to redirect_to(gallery_path Photo.last.id)
      end
    end

    xdescribe 'when fail' do # TODO: Fix controller to gracefully fail
      it 'should not save without variety_code' do
        photo_params[:variety_code] = ''
        expect { make_request }.to change { Photo.count }.by(0)
      end
    end
  end
end

def encoded_image_name(path)
  URI.encode(path.split('/')[-1])
end
