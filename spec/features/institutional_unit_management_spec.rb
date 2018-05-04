require 'rails_helper'

RSpec.feature 'Institutional Unit Management' do
  let(:unit_attrs) { attributes_for(:institutional_unit) }
  let(:unit) { create(:institutional_unit) }
  let!(:institution) { create(:institution) }
  let(:note_attrs) { attributes_for(:note) }


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
        visit "/institutions/#{institution.slug}"
        click_link 'Add new institutional unit'

        fill_in 'institutional_unit_name', with: unit_attrs[:name]
        click_button 'Create Unit'

        expect(page).to have_content(I18n.t('helpers.creation', display_name: unit_attrs[:name]))
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

  describe 'Creating a note' do
    scenario 'User visits unit and creates a note' do
      visit "/institutions/#{unit.institution.slug}/institutional-units/#{unit.slug}"
      fill_in 'institutional_unit_notes_attributes_0_text', with: note_attrs[:text]
      click_button 'Save Note'

      expect(page).to have_content(note_attrs[:text])
      expect(page).to have_content(I18n.t('helpers.update', display_name: unit.name))
    end
  end
end
