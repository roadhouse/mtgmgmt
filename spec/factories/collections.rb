FactoryGirl.define do
  factory :collection do
    user
    name "game"
    list({
      "Erase" => {
        "total" => 4, 
        "Khans of Tarkir" => {
          "normal" => 4
        } 
      },

      "Roast" => {
        "total" => 2, 
        "Khans of Tarkir" => {
          "normal" => 2
        } 
      } 
    })
  end
end
