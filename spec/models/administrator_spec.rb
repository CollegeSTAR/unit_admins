require 'rails_helper'

RSpec.describe Administrator do
  describe 'validations' do
    it { should validate_presence_of(:job_title) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_uniqueness_of(:job_title).scoped_to([:first_name, :last_name]) }
  end

  describe 'associations' do
    it { should belong_to(:institutional_unit).optional }
    it { should have_one(:administrative_assistant).dependent(:destroy) }
  end

  describe "accepts_nested_attributes_for" do
    it { should accept_nested_attributes_for(:administrative_assistant).allow_destroy(true) }
  end

  describe 'other_job_title' do
    context 'with no job title value set' do
      it 'should set job_title to other_job_title value' do
        other_job_title = 'Another job title'
        admin = Administrator.new other_job_title: other_job_title
        expect(admin.job_title).to eq(other_job_title)
      end
    end
    context 'with job title value set' do
      it 'should not set job_title value' do
        job_title = 'Job title'
        other_job_title = 'Another job title'
        admin = Administrator.new other_job_title: other_job_title, job_title: job_title
        expect(admin.job_title).to eq(job_title)
      end
    end
  end
end
