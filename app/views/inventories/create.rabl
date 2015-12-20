node(:inventory) do
  {
    card_id: @inventory.card_id,
    user_id: @inventory.user_id,
    list: @inventory.list,
    copies: @inventory.copies
  }
end
