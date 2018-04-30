require 'rails_helper'

RSpec.describe InstitutionalUnit do

  let(:unit) { create(:institutional_unit) }

  describe 'validations' do
    subject { create(:institutional_unit) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
  end
  
  describe 'associations' do
    it { should belong_to(:institution) }
  end

  describe 'to_param' do
    it 'returns slug' do
      expect(unit.to_param).to eq(unit.slug)
    end
  end
end
