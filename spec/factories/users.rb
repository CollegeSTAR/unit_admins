require 'rails_helper'

FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John_#{n}" }
    sequence(:last_name) { |n| "Smith_#{n}" }
    email { "#{first_name}.#{last_name}@example.com" }
    password 'testtest123'
    password_confirmation 'testtest123'

    institution
  end
end
