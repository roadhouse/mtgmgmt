FactoryGirl.define do
  sequence(:email) { |n| "username#{n}@email.com" }

  factory :user do
    login "login_user"
    email
    password "12345678"
  end
end
