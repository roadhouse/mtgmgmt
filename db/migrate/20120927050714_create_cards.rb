class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name, :image, :set, :color, :manacost, :card_type, :power, :toughness, :rarity, :artist, :number, :number_ex
      t.references :edition
      t.integer :loyalty
      t.text :text
      t.timestamps
    end
  end
end
