require 'rails_helper'

RSpec.feature 'Department management' do
  let!(:institution) { create(:institution_with_units) } 
  let(:department_attrs) { attributes_for(:department) }
  describe 'Department creation' do
    scenario 'user creates a new department' do
      visit "/institutions/#{institution.slug}/institutional-units/#{institution.institutional_units.first.slug}/departments/new"
      fill_in 'department_name', with: department_attrs[:name]

      click_button 'Create Department'

      expect(page).to have_content('Successfully created department.')
    end
  end
end
