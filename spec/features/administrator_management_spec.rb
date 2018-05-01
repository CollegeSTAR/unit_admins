require 'rails_helper'

RSpec.feature 'Administrator Management' do
  let(:institutional_unit) { create(:institutional_unit) }
  let(:admin_attrs) { attributes_for(:administrator) }

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
    end
  end
end
