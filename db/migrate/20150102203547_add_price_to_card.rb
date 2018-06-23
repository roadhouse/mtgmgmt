class AddPriceToCard < ActiveRecord::Migration[4.2]
  def change
    add_column :cards, :price, :decimal
  end
end
