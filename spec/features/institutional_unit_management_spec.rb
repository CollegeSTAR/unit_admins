require 'rails_helper'

RSpec.feature 'Institutional Unit Management' do
  let(:unit_attrs) { attributes_for(:institutional_unit) }
  let(:unit) { create(:institutional_unit) }


  describe 'Displays an index of units' do
    before(:each) do
      unit
    end

    scenario 'User visits index' do
      visit '/institutional-units'

      expect(page).to have_content(unit.name)
    end
  end

  describe 'Create a new unit' do
    scenario 'User fills out new unit form' do
      visit '/institutional-units/new'

      fill_in 'institutional_unit_name', with: unit_attrs[:name]
      click_button 'Create Unit'

      expect(page).to have_content('Institutional Unit successfully created.')
    end
  end
end
