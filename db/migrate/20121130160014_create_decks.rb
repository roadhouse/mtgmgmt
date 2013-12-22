class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.text :description
      t.string :url
      t.date :date

      t.timestamps
    end
  end
end
