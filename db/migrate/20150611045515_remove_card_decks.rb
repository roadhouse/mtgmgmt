class RemoveCardDecks < ActiveRecord::Migration
  def change
    drop_table :card_decks
  end
end
