require 'rails_helper'

RSpec.describe DepartmentAdministrator do
  
  describe 'associations' do
    it { should belong_to(:department) }
  end
end
