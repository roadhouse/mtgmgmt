FactoryGirl.define do
  factory :inventory do
    user
    card
    list "game"
    copies 1
  end
end
