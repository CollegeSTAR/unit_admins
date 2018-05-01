require 'rails_helper'

RSpec.describe InstitutionalUnitAdministratorAssociation do
  
  describe 'associations' do
    it { should belong_to(:institutional_unit) }
    it { should belong_to(:administrator) }
  end
end
