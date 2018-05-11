require 'rails_helper'

RSpec.feature 'Department management' do
  let!(:institution) { create(:institution_with_units) } 
  let(:department) { create(:department) }
  let(:department_attrs) { attributes_for(:department) }
  let(:department_admin) { create(:department_administrator) }
  let(:note_attrs) { attributes_for(:note) }

  before(:each) do
    sign_in create(:user)
  end

  describe 'Department creation' do
    context 'With correct params' do
      scenario 'user creates a new department' do
        visit "/institutions/#{institution.slug}/institutional-units/#{institution.institutional_units.first.slug}"
        click_link 'Add new department'

        fill_in 'department_name', with: department_attrs[:name]
        click_button 'Create Department'

        expect(page).to have_content(I18n.t('helpers.creation', display_name: department_attrs[:name]))
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

  describe "Department lists it's administrators" do
    before(:each) { department_admin }
    
    scenario 'User visits a department with existing admins and sees a list of them' do
      institution = department_admin.department.institution
      institutional_unit = department_admin.department.institutional_unit
      department = department_admin.department
      visit "/institutions/#{institution.slug}/institutional-units/#{institutional_unit.slug}/departments/#{department.slug}"

      expect(page).to have_content("#{department_admin.first_name} #{department_admin.last_name}")
    end
  end

  describe 'Creating a note' do
    scenario 'User visits department and creates a note' do
      visit "/institutions/#{department.institution.slug}"\
        "/institutional-units/#{department.institutional_unit.slug}"\
        "/departments/#{department.slug}"
      fill_in 'department_notes_attributes_0_text', with: note_attrs[:text]
      click_button 'Save Note'

      expect(page).to have_content(note_attrs[:text])
      expect(page).to have_content(I18n.t('helpers.update', display_name: department.name))
    end
  end

  describe 'Editing a department' do
    before(:each) do
      department
    end
    scenario 'User edits an existing department' do
      new_name = 'New Department Name'
      visit "/institutions/#{department.institution.slug}"\
        "/institutional-units/#{department.institutional_unit.slug}"\
        "/departments/#{department.slug}/edit"
      fill_in 'department_name', with: new_name
      click_button I18n.t('helpers.submit.update')

      expect(page).to have_content(new_name)
      expect(page).to have_content(I18n.t('helpers.update', display_name: new_name))
    end
  end
end
