FactoryGirl.define do
  factory :user do
    name "Sharky Fitzgerald"
    email "sharky@sharkyfries.com"
    password "12345" # it's the same combination he has on his luggage
    password_confirmation "12345"
  end
end
