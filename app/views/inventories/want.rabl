collection @inventories, object_root: false

attributes :copies
node(:id) {|i| i.card.id}
node(:name) {|i| i.card.name}
node(:ctype) {|i| i.card.ctype}
node(:portuguese_name) {|i| i.card.portuguese_name}
node(:price) {|i| i.card.price}
node(:image) {|i| i.card.image}

node(:priceStatus) do |i|
  current, most_recent = i.card.prices.order(created_at: :desc).limit(2).pluck(:value)

  if current.to_f == most_recent.to_f
    "equal"
  else
    current.to_f > most_recent.to_f ? "up" : "down"
  end
end
