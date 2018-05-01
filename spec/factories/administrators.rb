require 'rails_helper'

FactoryBot.define do
  factory :administrator do
    job_title 'Dean'
    title 'Dr.'
    sequence(:first_name) { |n| "Jane-#{n}" }
    sequence(:last_name) { |n| "Smith-#{n}" }
    email { "#{first_name}.#{last_name}@example.com" }
    phone_number '252-328-1111'
    mail_stop '100'
    sec_loc '1001A Joyner'
    interim true

    factory :administrator_with_other_job_title do
      job_title ''
      other_job_title 'Dean of Students'
    end
  end
end
