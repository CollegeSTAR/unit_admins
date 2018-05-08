require 'rails_helper'

RSpec.feature 'Session Management' do
  let(:user) { create(:user) }
  
  describe 'Creating a new session' do
    scenario 'user visits login page and enters account info' do
      visit '/'
      click_link 'login'
      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password
      click_button 'Log in'

      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
      expect(page).to have_current_path(institution_path(slug: user.institution.slug))
    end
  end
end
