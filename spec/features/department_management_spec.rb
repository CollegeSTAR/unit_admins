require 'rails_helper'

RSpec.feature 'Department management' do
  let!(:institution) { create(:institution_with_units) } 
  let(:department) { create(:department) }
  let(:department_attrs) { attributes_for(:department) }
  
  describe 'Department creation' do
    context 'With correct params' do
      scenario 'user creates a new department' do
        visit "/institutions/#{institution.slug}/institutional-units/#{institution.institutional_units.first.slug}"
        click_link 'Add new department'

        fill_in 'department_name', with: department_attrs[:name]
        click_button 'Create Department'

        expect(page).to have_content('Successfully created department.')
      end
    end
    context 'With incorrect params' do
      scenario 'user creates a new department' do
        visit "/institutions/#{institution.slug}/institutional-units/#{institution.institutional_units.first.slug}"
        click_link 'Add new department'

        click_button 'Create Department'

        expect(page).to have_content("Name can't be blank")
      end
    end
  end

  describe 'Unit department list' do
    scenario 'user visits a unit and sees a list of departments' do
      visit "/institutions/#{department.institution.slug}/institutional-units/#{department.institutional_unit.slug}"
      click_link department.name

      expect(page).to have_content(department.name)
    end
  end
end
