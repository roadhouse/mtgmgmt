class AddSeasonToDeck < ActiveRecord::Migration[4.2]
  def change
    add_column :decks, :season, :string
  end
end
