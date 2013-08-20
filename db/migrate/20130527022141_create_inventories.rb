class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :quantity
      t.references :card, :user, :language
      t.boolean :foil
      t.string :price
      t.timestamps
    end
  end
end
