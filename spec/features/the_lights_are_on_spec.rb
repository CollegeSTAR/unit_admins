require 'rails_helper'

RSpec.feature "Check root path works" do
  
  scenario "user visits root path" do
    visit "/"

    expect(page).to have_http_status :ok
  end
end
