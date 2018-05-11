require 'rails_helper'

RSpec.feature 'Administrator Management' do
  let(:institutional_unit) { create(:institutional_unit) }
  let(:department) { create(:department) }
  let(:unit_admin) { create(:unit_administrator) }
  let(:department_admin) { create(:department_administrator) }
  let(:admin_attrs) { attributes_for(:administrator) }
  let(:admin_assistant_attrs) { attributes_for(:administrative_assistant) }
  let(:note_attrs) { attributes_for(:note) }

  before(:each) do
    sign_in create(:user)
  end

  describe 'Institutional Unit Administrator creation' do
    scenario 'user adds an administrator' do
      visit "/institutions/#{institutional_unit.institution.slug}/institutional-units/#{institutional_unit.slug}"
      click_link 'Add an administrator'
      
      select('Dean', from: 'unit_administrator_job_title')
      select('Dr.', from: 'unit_administrator_title')
      fill_in 'unit_administrator_first_name', with: admin_attrs[:first_name]
      fill_in 'unit_administrator_last_name', with: admin_attrs[:last_name]
      fill_in 'unit_administrator_email', with: admin_attrs[:email]
      fill_in 'unit_administrator_phone_number', with: admin_attrs[:phone_number]
      fill_in 'unit_administrator_mail_stop', with: admin_attrs[:mail_stop]
      fill_in 'unit_administrator_sec_loc', with: admin_attrs[:sec_loc]
      check 'unit_administrator_interim'
      
      click_button I18n.t('helpers.submit.create', model: UnitAdministrator.model_name.human)
      expect(page).to have_content('Successfully added administrator.')
      expect(Administrator.last.email).to eq(admin_attrs[:email])
    end

    context 'with administrative assistant' do
      scenario "User adds an administrator" do
        visit "/institutions/#{institutional_unit.institution.slug}/institutional-units/#{institutional_unit.slug}"
        click_link 'Add an administrator'
        
        select('Dean', from: 'unit_administrator_job_title')
        select('Dr.', from: 'unit_administrator_title')
        fill_in 'unit_administrator_first_name', with: admin_attrs[:first_name]
        fill_in 'unit_administrator_last_name', with: admin_attrs[:last_name]
        fill_in 'unit_administrator_email', with: admin_attrs[:email]
        fill_in 'unit_administrator_phone_number', with: admin_attrs[:phone_number]
        fill_in 'unit_administrator_mail_stop', with: admin_attrs[:mail_stop]
        fill_in 'unit_administrator_sec_loc', with: admin_attrs[:sec_loc]
        check 'unit_administrator_interim'
        
        fill_in 'unit_administrator_administrative_assistant_attributes_first_name',
                with: admin_assistant_attrs[:first_name]
        fill_in 'unit_administrator_administrative_assistant_attributes_last_name',
                with: admin_assistant_attrs[:last_name]
        fill_in 'unit_administrator_administrative_assistant_attributes_email',
                with: admin_assistant_attrs[:email]
        fill_in 'unit_administrator_administrative_assistant_attributes_phone_number',
                with: admin_assistant_attrs[:phone_number]
        fill_in 'unit_administrator_administrative_assistant_attributes_mail_stop',
                with: admin_assistant_attrs[:mail_stop]
        fill_in 'unit_administrator_administrative_assistant_attributes_address',
                with: admin_assistant_attrs[:address]

        click_button I18n.t('helpers.submit.create', model: UnitAdministrator.model_name.human)
        
        expect(page).to have_content('Successfully added administrator.')
        expect(AdministrativeAssistant.last.email).to eq(admin_assistant_attrs[:email])
      end
    end
  end

  describe 'Institutional Unit Administrator updating' do
    scenario 'User visits unit admin page and updates the admin info' do
      new_first_name = 'Jane'
      new_last_name = 'Smith'
      new_email = 'jane.smith01@example.com'

      visit "/institutions/#{unit_admin.institution.slug}"\
        "/institutional-units/#{unit_admin.institutional_unit.slug}"\
        "/administrators/#{unit_admin.id}/edit"
      fill_in 'unit_administrator_first_name', with: new_first_name
      fill_in 'unit_administrator_last_name', with: new_last_name
      fill_in 'unit_administrator_email', with: new_email
      click_button I18n.t('helpers.submit.update')

      expect(page).to have_content(I18n.t('helpers.update', display_name: unit_admin.job_title))
      expect(page).to have_content(new_first_name)
      expect(page).to have_content(new_last_name)
      expect(page).to have_content(new_email)
    end
    scenario 'User visits unit admin show page and adds a note' do
      visit "/institutions/#{unit_admin.institution.slug}"\
        "/institutional-units/#{unit_admin.institutional_unit.slug}"\
        "/administrators/#{unit_admin.id}"

      fill_in 'unit_administrator_notes_attributes_0_text', with: note_attrs[:text]
      click_button 'Save Note'

      expect(page).to have_content(note_attrs[:text])
      expect(page).to have_content(I18n.t('helpers.update', display_name: unit_admin.job_title))
    end
  end

  describe 'Department Administrator creation' do
    scenario 'user adds an administrator' do
      visit "/institutions/#{department.institution.slug}"\
        "/institutional-units/#{department.institutional_unit.slug}"\
        "/departments/#{department.slug}"
      click_link 'Add an administrator'
      
      select('Dean', from: 'department_administrator_job_title')
      select('Dr.', from: 'department_administrator_title')
      fill_in 'department_administrator_first_name', with: admin_attrs[:first_name]
      fill_in 'department_administrator_last_name', with: admin_attrs[:last_name]
      fill_in 'department_administrator_email', with: admin_attrs[:email]
      fill_in 'department_administrator_phone_number', with: admin_attrs[:phone_number]
      fill_in 'department_administrator_mail_stop', with: admin_attrs[:mail_stop]
      fill_in 'department_administrator_sec_loc', with: admin_attrs[:sec_loc]
      check 'department_administrator_interim'
      
      fill_in 'department_administrator_administrative_assistant_attributes_first_name',
              with: admin_assistant_attrs[:first_name]
      fill_in 'department_administrator_administrative_assistant_attributes_last_name',
              with: admin_assistant_attrs[:last_name]
      fill_in 'department_administrator_administrative_assistant_attributes_email',
              with: admin_assistant_attrs[:email]
      fill_in 'department_administrator_administrative_assistant_attributes_phone_number',
              with: admin_assistant_attrs[:phone_number]
      fill_in 'department_administrator_administrative_assistant_attributes_mail_stop',
              with: admin_assistant_attrs[:mail_stop]
      fill_in 'department_administrator_administrative_assistant_attributes_address',
              with: admin_assistant_attrs[:address]

      click_button I18n.t('helpers.submit.create', model: DepartmentAdministrator.model_name.human)
      expect(page).to have_content(I18n.t('helpers.creation', display_name: 'Dean'))
      expect(AdministrativeAssistant.last.email).to eq(admin_assistant_attrs[:email])
    end
  end

  describe 'Department Administrator updating' do
    scenario 'User visits unit admin page and updates the admin info' do
      new_first_name = 'Jane'
      new_last_name = 'Smith'
      new_email = 'jane.smith01@example.com'

      visit "/institutions/#{department_admin.institution.slug}"\
        "/institutional-units/#{department_admin.institutional_unit.slug}"\
        "/departments/#{department_admin.department.slug}"\
        "/administrators/#{department_admin.id}/edit"

      fill_in 'department_administrator_first_name', with: new_first_name
      fill_in 'department_administrator_last_name', with: new_last_name
      fill_in 'department_administrator_email', with: new_email
      click_button I18n.t('helpers.submit.update')

      expect(page).to have_content(I18n.t('helpers.update', display_name: department_admin.job_title))
      expect(page).to have_content(new_first_name)
      expect(page).to have_content(new_last_name)
      expect(page).to have_content(new_email)
    end
    scenario 'User visits unit admin show page and adds a note' do
      visit "/institutions/#{unit_admin.institution.slug}"\
        "/institutional-units/#{unit_admin.institutional_unit.slug}"\
        "/administrators/#{unit_admin.id}"

      fill_in 'unit_administrator_notes_attributes_0_text', with: note_attrs[:text]
      click_button 'Save Note'

      expect(page).to have_content(note_attrs[:text])
      expect(page).to have_content(I18n.t('helpers.update', display_name: unit_admin.job_title))
    end
    scenario 'User visits department admin show page and adds a note' do
      visit "/institutions/#{department_admin.institution.slug}"\
        "/institutional-units/#{department_admin.institutional_unit.slug}"\
        "/departments/#{department_admin.department.slug}"\
        "/administrators/#{department_admin.id}"

      fill_in 'department_administrator_notes_attributes_0_text', with: note_attrs[:text]
      click_button 'Save Note'

      expect(page).to have_content(note_attrs[:text])
      expect(page).to have_content(I18n.t('helpers.update', display_name: department_admin.job_title))
    end
  end
end
