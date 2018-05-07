require 'rails_helper'

RSpec.describe User do

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
  end

  describe 'associations' do
    it { should belong_to(:institution) }
  end
end
