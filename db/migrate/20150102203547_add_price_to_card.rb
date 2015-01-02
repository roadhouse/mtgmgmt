class AddPriceToCard < ActiveRecord::Migration
  def change
    add_column :cards, :price, :decimal
  end
end
