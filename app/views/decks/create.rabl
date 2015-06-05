node(:manacost_labels) { @deck.by_manacost.keys.sort }
node(:manacost_data) { @deck.total_by_manacost.values }
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
