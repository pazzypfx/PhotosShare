require 'rails_helper'

RSpec.describe Variety, type: :model do
  describe 'associations' do
    it { should have_many(:photos) }
    it { should belong_to(:product) }
  end
  describe 'validations' do
    it { should validate_uniqueness_of(:variety_code) }
    it { should validate_presence_of(:variety_code) }
    it { should validate_presence_of(:product) }
  end
end
