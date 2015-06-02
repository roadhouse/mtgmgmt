node(:manacost_labels) { @deck.by_manacost.keys.sort }
node(:manacost_data) { @deck.total_by_manacost.values }
node :mana do
  { 
    type: "mana",
    labels: @deck.by_manacost.keys.sort, 
    datasets: [ { data: @deck.total_by_manacost.values } ]
  }
end
