FactoryGirl.define do
  factory :measurement_unit do
    sequence(:name) { |n| "cups (#{n})" }
  end
end
