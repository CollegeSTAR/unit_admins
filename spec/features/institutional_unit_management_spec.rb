require 'rails_helper'

RSpec.feature 'Institutional Unit Management' do
  let(:unit_attrs) { attributes_for(:institutional_unit) }
  let(:unit) { create(:institutional_unit) }
  let!(:institution) { create(:institution) }


  describe 'Displays an index of units' do
    before(:each) do
      unit
    end

    scenario 'User visits index' do
      visit "/institutions/#{unit.institution.slug}/institutional-units"

      expect(page).to have_content(unit.name)
    end
  end

  describe 'Create a new unit' do
    
    context "with correct params" do
      scenario 'User fills out new unit form' do
        visit "/institutions/#{institution.slug}/institutional-units/new"

        fill_in 'institutional_unit_name', with: unit_attrs[:name]
        click_button 'Create Unit'

        expect(page).to have_content('Institutional Unit successfully created.')
      end
    end
    
    context 'without correct params' do
      scenario 'User fills out new unit form' do
        visit "/institutions/#{institution.slug}/institutional-units/new"

        click_button 'Create Unit'

        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
