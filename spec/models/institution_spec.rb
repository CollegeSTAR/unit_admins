require 'rails_helper'

RSpec.describe Institution do
 let(:institution) { create(:institution) } 

  describe 'validations' do
    subject { create(:institution) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe 'associations' do
    it { should have_many(:institutional_units).dependent(:destroy) }
    it { should have_many(:departments).dependent(:destroy) }
    it { should have_many(:notes).dependent(:destroy) }
  end

  describe 'to_param' do
    it 'should return slug' do
      expect(institution.to_param).to eq(institution.slug) 
    end
  end

  describe 'sync_slug' do
    it 'should sync the slug to the name on save' do
      institution
      institution.name = 'Another institution name'
      institution.save
      institution.reload
      expect(institution.slug).to eq(institution.name.parameterize)
    end
  end
end
