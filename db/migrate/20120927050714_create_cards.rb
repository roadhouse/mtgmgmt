class CreateCards < ActiveRecord::Migration
  # foreignNames: [hstore],
  # legalities: {hstore},
  # rulings: [hstore],
  def change
    create_table :cards do |t|
      t.string :name, :image, :set, :mana_cost, :ctype, :power, :toughness, :rarity, :artist, :number, :number_ex, :rarity, :original_type, :layout, :border

      t.text :original_text, :flavor

      t.integer :loyalty, :number, :toughness, :multiverse_id, :cmc

      t.string :ctypes, array: true, default: []
      t.string :subtypes, array: true, default: []
      t.string :printings, array: true, default: []
      t.string :names, array: true, default: []
      t.string :colors, array: true, default: []
      t.string :supertypes, array: true, default: []

      t.timestamps
    end
  end
end
