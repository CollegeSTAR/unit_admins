require 'rails_helper'

FactoryBot.define do
  factory :institution do
    sequence(:name) { |n| "Institution #{n}" }
    slug { "#{name}".parameterize }
  end
end
