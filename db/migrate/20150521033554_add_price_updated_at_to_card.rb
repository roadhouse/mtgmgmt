class AddPriceUpdatedAtToCard < ActiveRecord::Migration[4.2]
  def change
    add_column :cards, :price_updated_at, :datetime
  end
end
