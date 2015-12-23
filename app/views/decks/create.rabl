node(:deck_list) { @deck.deck_list(:main) }
node(:deck_size) { @deck.deck_list.map { |x| x.fetch(:copies)  }.sum }
node(:first_hand) { @deck.first_hand }
node(:isValid) { @deck.deck.main.size >= 36 }

node :mana do
  {
    labels: @deck.by_manacost.keys.sort,
    data: [ @deck.total_by_manacost.values ]
  }
end

node :color do
  {
    labels: @deck.total_by_color.keys.sort
              .delete_if { |key,_| key == :colorless },
    data: @deck.total_by_color.values,
    colors: @deck.async_color
  }
end

node :type do
  {
    labels: @deck.total_by_type.keys.sort,
    data: @deck.total_by_type.values
  }
end
