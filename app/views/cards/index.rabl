collection @cards, object_root: false

attributes :id, :name, :ctype, :portuguese_name, :price, :image

node(:priceStatus) do |card|
  current, most_recent = card.prices.order(created_at: :desc).limit(2).pluck(:value)

  if current.to_f == most_recent.to_f
    "equal"
  else
    current.to_f > most_recent.to_f ? "up" : "down"
  end 
end

node(:original_text) do |card| 
  card.original_text
    .gsub("{R}", "<i class='mtg red'></i>")
    .gsub("{G}", "<i class='mtg green'></i>")
    .gsub("{U}", "<i class='mtg blue'></i>")
    .gsub("{W}", "<i class='mtg white'></i>")
    .gsub("{B}", "<i class='mtg black'></i>")
    .gsub("{T}", "<i class='mtg tap'></i>")
    .gsub(/{X}/, "<i class='mtg mana-x></i>")
    .gsub(/{(\d)}/, '<i class=\'mtg mana-\1\'></i>')
end

node(:set) do |card|
  "<span class='mtg #{[Card::ICON_NAME[card.set.to_sym],card.rarity.to_s.downcase].join(" ")}'></span>"
end

node(:mana_cost) do |card|
  card.mana_cost
    .gsub("{R}", "<i class='mtg red'></i>")
    .gsub("{G}", "<i class='mtg green'></i>")
    .gsub("{U}", "<i class='mtg blue'></i>")
    .gsub("{W}", "<i class='mtg white'></i>")
    .gsub("{B}", "<i class='mtg black'></i>")
    .gsub("{T}", "<i class='mtg tap'></i>")
    .gsub(/{X}/, "<i class='mtg mana-x></i>")
    .gsub(/{(\d)}/, '<i class=\'mtg mana-\1\'></i>')
end
