require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:variety) }
    it { should have_one(:product) }
    it { should belong_to(:place) }
  end
  describe 'validations' do
    it { should validate_presence_of(:path) }
  end
end
