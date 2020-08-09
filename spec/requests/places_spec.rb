require 'rails_helper'

RSpec.describe 'Places', type: :request do
  before { login_as(FactoryBot.create(:user, :admin)) }
  after { Warden.test_reset! }

  describe 'GET /places' do
    let(:make_request) { get places_path }

    let!(:place1) { create(:place) }
    let!(:place2) { create(:place) }

    it 'should list all places' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      for place in [place1, place2] do
        expect(body).to include(place.name)
        expect(body).to include(place.place_code.to_s)
      end
    end
  end

  describe 'GET /places/:id' do
    let(:make_request) { get place_path(place1.id) }

    let!(:place1) { create(:place) }
    let!(:place2) { create(:place) }

    it 'should show place' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      expect(body).to include(place1.name)
      expect(body).to include(place1.place_code.to_s)
    end

    it 'should not show other places' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      all_info = body.include?(place2.name) &&
                 body.include?(place2.place_code.to_s)
      expect(all_info).not_to be(true)
    end
  end

  describe 'POST /places' do
    let(:make_request) { post places_path, params: { place: place_params } }

    let!(:place) { build(:place) }
    let!(:place_params) do
      {
        name: place.name,
        place_code: place.place_code,
      }
    end

    describe 'when success' do
      it 'should create place' do
        expect { make_request }.to change { Place.count }.by(1)
      end

      it 'should redirect to place' do
        make_request
        expect(response).to redirect_to(place_path Place.last.id)
      end
    end

    describe 'when fail' do
      it 'should not save without place_code' do
        place_params[:place_code] = ''
        expect { make_request }.to change { Place.count }.by(0)
      end
    end
  end

  describe 'PATCH /places/:id' do
    let(:make_request) { patch place_path(place.id), params: { place: place_params } }

    let!(:place) { create(:place) }
    let!(:update) { build(:place) }
    let!(:place_params) do
      {
        name: update.name,
        place_code: update.place_code,
      }
    end

    describe 'when success' do
      it 'should update place' do
        expect { make_request }.to change { place.reload.attributes }
        expect(place.name).to eq(update.name)
        expect(place.place_code).to eq(update.place_code)
      end

      it 'should redirect to place' do
        make_request
        expect(response).to redirect_to(place_path place.id)
      end
    end

    describe 'when fail' do
      it 'should not save without name' do
        place_params[:place_code] = ''
        make_request
        place.reload.attributes

        all_info = place.name == update.name &&
                   place.place_code == update.place_code
        expect(all_info).not_to be(true)
      end
    end
  end

  describe 'DELETE /places/:id' do
    let(:make_request) { delete place_path(place.id) }

    let!(:place) { create(:place) }

    it 'should delete place' do
      expect { make_request }.to change { Place.count }.by(-1)
    end

    it 'should redirect to places' do
      make_request
      expect(response).to redirect_to(places_path)
    end
  end
end
