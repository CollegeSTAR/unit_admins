require 'rails_helper'

RSpec.feature 'Institution management' do
  
  let(:institution_attrs) { attributes_for(:institution) }
  let!(:institution) { create(:institution) }
  let(:institution_with_units) { create(:institution_with_units) }

  describe 'Index' do
    scenario 'User visits Institution index page' do
      visit '/institutions'

      expect(page).to have_content(institution.name)
    end

    scenario 'User clicks an institution link' do
      visit '/institutions'
      find(:xpath, "//a[@href='/institutions/#{institution.slug}']").click

      expect(page).to have_content(institution.name)
    end
  end
  
  describe 'Show Action' do
    scenario 'User visits an Institions show page' do
      visit "/institutions/#{institution.slug}"

      expect(page).to have_content(institution.name)
    end

    context 'With child institutional_units' do
      scenario 'User visits an Institution and see institutional_units' do
       unit = institution_with_units.institutional_units.first
       visit "/institutions/#{institution_with_units.slug}"
       find(:xpath, "//a[@href='/institutions/#{institution_with_units.slug}/institutional-units/#{unit.slug}']").click

       expect(page).to have_content(unit.name)
      end
    end
  end

  describe 'New Action' do
    context 'With correct params' do
      scenario 'User fills out form for new institution' do
        visit '/institutions/new'
        fill_in 'Name', with: institution_attrs[:name]
        click_button 'Create Institution'

        expect(page).to have_content('Successfully created institution.')
      end
    end
    context 'With incorrect params' do
      scenario 'User fills out form for new institution' do
        visit '/institutions/new'
        click_button 'Create Institution'

        expect(page).to have_content("Name can't be blank.")
      end
    end
  end
end