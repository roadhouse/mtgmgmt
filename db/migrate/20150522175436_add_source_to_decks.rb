class AddSourceToDecks < ActiveRecord::Migration[4.2]
  def change
    add_column :decks, :source, :string
  end
end
