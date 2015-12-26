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
