require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST /sessions' do
    let(:make_request) { post sessions_path, params: payload }

    let!(:user) { create(:user, password: 'password') }
    let!(:payload) { { username: user.username, password: 'password' } }

    it 'should login' do
      make_request
      expect(response).to redirect_to(photos_path)
    end

    describe 'when agent' do
      let!(:user) { create(:user, :agent, password: 'password') }
      let!(:payload) { { username: user.username, password: 'password' } }

      it 'should login' do
        make_request
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'when fail' do
      it 'should show error message' do
        payload[:password] = ''
        make_request
        expect(response.body).to include('Invalid email or password!')
      end
    end
  end

  describe 'DELETE /sessions' do
    before { login_as(FactoryBot.create(:user, :admin)) }
    after { Warden.test_reset! }

    let(:make_request) { get '/logout' }

    it 'should logout' do
      make_request
      expect(response).to redirect_to(login_path)
    end
  end
end
