FactoryBot.define do
  factory :institutional_unit do
    sequence(:name) { |n| "Institutional Unit #{n}" }
    slug { "#{name}".parameterize }

    institution
  end
end
