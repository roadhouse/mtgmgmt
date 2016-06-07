FactoryGirl.define do
  factory :card do
    name "Zulaport Cutthroat"
    image ""
    set "BFZ"
    mana_cost "{1}{B}"
    ctype "Creature — Human Rogue Ally"
    power 1
    toughness 1
    rarity "Uncommon"
    artist "Jason Rainville"
    number 126
    number_ex nil
    original_type "Creature — Human Rogue Ally"
    layout "normal"
    border "black"
    portuguese_name "Degolador de Zulaport"
    original_text "Whenever Zulaport Cutthroat or another creature you control dies, each opponent loses 1 life and you gain 1 life."
    flavor "\"Eldrazi? Ha! Try walking through Zulaport at night with your pockets full. Now that's dangerous.\""
    loyalty 0
    multiverse_id 402101
    cmc 2
    ctypes [ "Creature" ]
    subtypes [ "Human" "Rogue" "Ally" ]
    printings [ "BFZ" ]
    is_standard true
  end
end
