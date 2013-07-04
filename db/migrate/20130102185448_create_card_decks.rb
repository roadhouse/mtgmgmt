class CreateCardDecks < ActiveRecord::Migration
  def change
    create_table :card_decks do |t|
      t.integer :deck_id
      t.integer :card_id
      t.integer :copies, default: 1

      t.timestamps
    end
  end
end
