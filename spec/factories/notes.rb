require 'rails_helper'

FactoryBot.define do
  
  factory :note do
    sequence(:text) { |n| "Text for a note! #{n}" }
  end
end
