require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'associations' do
    it { should have_many(:photos) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:place_code) }
    it { should validate_presence_of(:place_code) }
  end
end
