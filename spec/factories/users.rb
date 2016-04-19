FactoryGirl.define do
  factory :user do
    name "Sharky Fitzgerald"
    email "sharky@sharkyfries.com"
    password "12345" # it's the same combination he has on his luggage
    password_confirmation "12345"

    # factory :user_2 do
    #   name "Wankel Rotary-Engine"
    #   email "wankel@engines.com"
    #   password "11111"
    #   password_confirmation "11111"
    # end
  end
end
