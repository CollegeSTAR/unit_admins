require 'rails_helper'

RSpec.describe UnitAdministrator do
  
  describe 'associations' do
    it { should belong_to(:institutional_unit) }
  end
end
