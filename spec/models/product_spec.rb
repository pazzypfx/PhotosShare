require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_many(:photos) }
    it { should have_many(:varieties) }
  end
  describe 'validations' do
    it { should validate_uniqueness_of(:product_code) }
    it { should validate_presence_of(:product_code) }
  end
end
