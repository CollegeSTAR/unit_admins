require 'rails_helper'

RSpec.describe Note do
  describe "validations" do
    it { should validate_presence_of(:text) }
  end

  describe "associations" do
    it { should belong_to(:institution).optional }
    it { should belong_to(:institutional_unit).optional }
    it { should belong_to(:department).optional }
    it { should belong_to(:administrator).optional }
  end
end
