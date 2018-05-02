require 'rails_helper'

RSpec.describe AdministrativeAssistant do
  
  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
  end

  describe "associations" do
    it { should belong_to(:administrator) }
  end
end
