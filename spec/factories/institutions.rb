require 'rails_helper'

FactoryBot.define do
  factory :institution do
    sequence(:name) { |n| "Institution #{n}" }
    slug { "#{name}".parameterize }

    factory :institution_with_units do
      after(:create) { |institution| institution.institutional_units << FactoryBot.create(:institutional_unit, institution: institution) }
    end
  end
end
