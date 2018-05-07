require 'rails_helper'

RSpec.describe Department do
  let(:department) { create(:department) }

  describe 'validations' do
    subject { create(:department) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe 'associations' do
    it { should belong_to(:institution) }
    it { should belong_to(:institutional_unit) }
    it { should have_many(:department_administrators).dependent(:destroy) }
    it { should have_many(:notes).dependent(:destroy) }
  end

  describe 'accepts_nested_attributes_for' do
    it { should accept_nested_attributes_for(:notes) }
  end

  describe "to_param" do
    it "should return slug" do
      expect(department.to_param).to eq(department.slug)
    end
  end

  describe "sync slug" do
    before(:each) do
      department
    end
    it "should sync the slug to name on save" do
      new_name = "A new name"
      department.name = new_name
      department.save
      department.reload
      expect(department.slug).to eq(department.name.parameterize)
    end
  end
end
