def deck_list
  {
    "main" => {
      "Plains" => 1,
      "Mountain" => 2,
      "Hammerhand" => 4,
      "Gods Willing" => 4,
      "Dragon Mantle" => 4,
      "Satyr Hoplite" => 3,
      "Defiant Strike" => 4,
      "Flooded Strand" => 2,
      "Phalanx Leader" => 1,
      "Akroan Crusader" => 3,
      "Favored Hoplite" => 4,
      "Mana Confluence" => 4,
      "Valorous Stance" => 2,
      "Ajani's Presence" => 3,
      "Titan's Strength" => 4,
      "Wooded Foothills" => 1,
      "Battlefield Forge" => 4,
      "Bloodstained Mire" => 1,
      "Coordinated Assault" => 4,
      "Monastery Swiftspear" => 4,
      "Lagonna-Band Trailblazer" => 1
    },
    "sideboard" => {
      "Erase" => 2,
      "Wild Slash" => 1,
      "Glare of Heresy" => 2,
      "Valorous Stance" => 2,
      "Ajani's Presence" => 1,
      "Lightning Strike" => 1,
      "Ordeal of Heliod" => 3,
      "Seeker of the Way" => 3
    },
    "main_cards" => "arbitrary_string"
  }
end

FactoryGirl.define do
  sequence(:url) { |n| "url#{n}" }

  factory :deck do
    name "Jeskai Heroic"
    description "8th Place at StarCityGames.com Invitational Qualifier on 5/25/2015"
    url
    season "FRF-JOU-KTK-M15-THS"
    source "starcitygames"
    list deck_list
  end
end
