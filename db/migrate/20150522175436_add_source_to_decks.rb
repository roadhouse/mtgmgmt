class AddSourceToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :source, :string
  end
end
