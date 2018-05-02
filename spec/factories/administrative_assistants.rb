require 'rails_helper'

FactoryBot.define do
  factory :administrative_assistant do
    sequence(:first_name) { |n| "John-#{n}" }
    sequence(:last_name) { |n| "Smith-#{n}" }
    email { "#{first_name}.#{last_name}@example.com" }
    phone_number "123-1234"
    mail_stop 514
    address "1001A Joyner Library"

    factory :administrative_assistant_with_administrator do
    
      administrator
    end
  end
end
