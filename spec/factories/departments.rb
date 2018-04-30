require 'rails_helper'

FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "Department #{n}" }
    slug { "#{name}".parameterize }
    
    institution
    institutional_unit
  end
end
