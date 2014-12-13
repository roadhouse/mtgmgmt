FactoryGirl.define do
  sequence(:url) { |n| "url#{n}" }
  
  factory :deck do
    name "red deck wins"
    url
  end
end
