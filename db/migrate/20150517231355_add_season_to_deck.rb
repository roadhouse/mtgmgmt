class AddSeasonToDeck < ActiveRecord::Migration
  def change
    add_column :decks, :season, :string
  end
end
