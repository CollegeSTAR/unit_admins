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
    it { should have_many(:departments).dependent(:destroy) }
    it { should have_many(:unit_administrators).dependent(:destroy) }
    it { should have_many(:notes).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:notes) }
  end

  describe 'to_param' do
    it 'returns slug' do
      expect(unit.to_param).to eq(unit.slug)
    end
  end

  describe 'sync_slug' do
    before(:each) do
      unit
    end

    it 'updates the slug when name is changed' do
      unit.name = 'New name'
      unit.save
      unit.reload
      expect(unit.slug).to eq(unit.name.parameterize)
    end
  end
end
