require 'rails_helper'

RSpec.feature 'Institutional Unit Management' do
  let(:unit_attrs) { attributes_for(:institutional_unit) }
  let(:unit) { create(:institutional_unit) }
  let!(:institution) { create(:institution) }
  let(:note_attrs) { attributes_for(:note) }

  before(:each) do
    sign_in create(:user)
  end

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
        click_button I18n.t('helpers.submit.create', model: InstitutionalUnit.model_name.human)

        expect(page).to have_content(I18n.t('helpers.creation', display_name: unit_attrs[:name]))
      end
    end
    
    context 'without correct params' do
      scenario 'User fills out new unit form' do
        visit "/institutions/#{institution.slug}/institutional-units/new"

        click_button I18n.t('helpers.submit.create', model: InstitutionalUnit.model_name.human)

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

  describe 'Edit a unit' do
    scenario 'User edits a unit' do
      new_name = 'Edited Unit Name'
      visit "/institutions/#{unit.institution.slug}/institutional-units/#{unit.slug}/edit"
      fill_in 'institutional_unit_name', with: new_name
      click_button I18n.t('helpers.submit.update')

      expect(page).to have_content(I18n.t('helpers.update', display_name: new_name))
      expect(page).to have_content(new_name)
    end
  end
end
