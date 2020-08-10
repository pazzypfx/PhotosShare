require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before { login_as(FactoryBot.create(:user, :admin)) }
  after { Warden.test_reset! }

  describe 'GET /users' do
    let(:make_request) { get users_path }

    let!(:user1) { create(:user) }
    let!(:user2) { create(:user, %i[agent manager].sample) }

    it 'should list all users' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      for user in [user1, user2] do
        expect(body).to include(user.username)
        expect(body).to include(user.first_name)
        expect(body).to include(user.last_name)
        expect(body).to include(user.role)
      end
    end
  end

  describe 'GET /users/:id' do
    let(:make_request) { get user_path(user1.id) }

    let!(:user1) { create(:user) }
    let!(:user2) { create(:user, %i[agent manager].sample) }

    it 'should show user' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      expect(body).to include(user1.username)
      expect(body).to include(user1.first_name)
      expect(body).to include(user1.last_name)
    end

    it 'should not show other users' do
      make_request

      expect(response).to be_successful

      body = CGI.unescapeHTML(response.body)
      all_info = body.include?(user2.username) &&
                 body.include?(user2.first_name) &&
                 body.include?(user2.last_name)
      expect(all_info).not_to be(true)
    end
  end

  describe 'POST /users' do
    let(:make_request) { post users_path, params: { user: user_params } }

    let!(:user) { build(:user) }
    let!(:user_params) do
      {
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        password: 'password',
        password_confirmation: 'password',
        active: user.active,
        role: user.role,
      }
    end

    describe 'when success' do
      it 'should create user' do
        expect { make_request }.to change { User.count }.by(1)
      end

      it 'should redirect to user' do
        make_request
        expect(response).to redirect_to(user_path User.last.id)
      end
    end

    describe 'when fail' do
      it 'should not save without username' do
        user_params[:username] = ''
        expect { make_request }.to change { User.count }.by(0)
      end

      it 'should not save when passwords differ' do
        user_params[:password_confirmation] = 'password2'
        expect { make_request }.to change { User.count }.by(0)
      end

      it 'should not save without role' do
        user_params[:role] = ''
        expect { make_request }.to change { User.count }.by(0)
      end
    end
  end

  describe 'PATCH /users/:id' do
    let(:make_request) { patch user_path(user.id), params: { user: user_params } }

    let!(:user) { create(:user) }
    let!(:update) { build(:user) }
    let!(:user_params) do
      {
        username: update.username,
        first_name: update.first_name,
        last_name: update.last_name,
        email: update.email,
        password: 'password',
        password_confirmation: 'password',
        active: update.active,
        role: update.role,
      }
    end

    describe 'when success' do
      it 'should update user' do
        expect { make_request }.to change { user.reload.attributes }
        expect(user.username).to eq(update.username)
        expect(user.first_name).to eq(update.first_name)
        expect(user.last_name).to eq(update.last_name)
        expect(user.email).to eq(update.email)
        expect(user.active).to eq(update.active)
        expect(user.role).to eq(update.role)
      end

      it 'should redirect to user' do
        make_request
        expect(response).to redirect_to(user_path user.id)
      end
    end

    xdescribe 'when fail' do
      it 'should not save without username' do
        user_params[:username] = ''
        make_request
        user.reload.attributes

        all_info = user.username == update.username &&
                   user.first_name == update.first_name &&
                   user.last_name == update.last_name
        expect(all_info).not_to be(true)
      end
    end
  end

  describe 'DELETE /users/:id' do
    let(:make_request) { delete user_path(user.id) }

    let!(:user) { create(:user) }

    it 'should delete user' do
      expect { make_request }.to change { User.count }.by(-1)
    end

    it 'should redirect to users' do
      make_request
      expect(response).to redirect_to(users_path)
    end
  end
end
