class AddPriceUpdatedAtToCard < ActiveRecord::Migration
  def change
    add_column :cards, :price_updated_at, :datetime
  end
end
