require 'rails_helper'

RSpec.feature 'Administrator Management' do
  let(:institutional_unit) { create(:institutional_unit) }
  let(:admin_attrs) { attributes_for(:administrator) }
  let(:admin_assistant_attrs) { attributes_for(:administrative_assistant) }

  describe 'Administrator creation' do
    scenario 'user adds an administrator' do
      visit "/institutions/#{institutional_unit.institution.slug}/institutional-units/#{institutional_unit.slug}"
      click_link 'Add an administrator'
      
      select('Dean', from: 'administrator_job_title')
      select('Dr.', from: 'administrator_title')
      fill_in 'administrator_first_name', with: admin_attrs[:first_name]
      fill_in 'administrator_last_name', with: admin_attrs[:last_name]
      fill_in 'administrator_email', with: admin_attrs[:email]
      fill_in 'administrator_phone_number', with: admin_attrs[:phone_number]
      fill_in 'administrator_mail_stop', with: admin_attrs[:mail_stop]
      fill_in 'administrator_sec_loc', with: admin_attrs[:sec_loc]
      check 'administrator_interim'
      
      click_button 'Create administrator'
      expect(page).to have_content('Successfully added administrator.')
      expect(Administrator.last.email).to eq(admin_attrs[:email])
    end

    context 'with administrative assistant' do
      scenario "User adds an administrator" do
        visit "/institutions/#{institutional_unit.institution.slug}/institutional-units/#{institutional_unit.slug}"
        click_link 'Add an administrator'
        
        select('Dean', from: 'administrator_job_title')
        select('Dr.', from: 'administrator_title')
        fill_in 'administrator_first_name', with: admin_attrs[:first_name]
        fill_in 'administrator_last_name', with: admin_attrs[:last_name]
        fill_in 'administrator_email', with: admin_attrs[:email]
        fill_in 'administrator_phone_number', with: admin_attrs[:phone_number]
        fill_in 'administrator_mail_stop', with: admin_attrs[:mail_stop]
        fill_in 'administrator_sec_loc', with: admin_attrs[:sec_loc]
        check 'administrator_interim'
        
        fill_in 'administrator_administrative_assistant_attributes_first_name',
                with: admin_assistant_attrs[:first_name]
        fill_in 'administrator_administrative_assistant_attributes_last_name',
                with: admin_assistant_attrs[:last_name]
        fill_in 'administrator_administrative_assistant_attributes_email',
                with: admin_assistant_attrs[:email]
        fill_in 'administrator_administrative_assistant_attributes_phone_number',
                with: admin_assistant_attrs[:phone_number]
        fill_in 'administrator_administrative_assistant_attributes_mail_stop',
                with: admin_assistant_attrs[:mail_stop]
        fill_in 'administrator_administrative_assistant_attributes_address',
                with: admin_assistant_attrs[:address]

        click_button 'Create administrator'
        expect(page).to have_content('Successfully added administrator.')
        expect(AdministrativeAssistant.last.email).to eq(admin_assistant_attrs[:email])
      end
    end
  end
end
