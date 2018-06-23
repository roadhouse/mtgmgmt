class ChangeQuantityToCopies < ActiveRecord::Migration[4.2]
  def change
    rename_column :inventories, :quantity, :copies
  end
end
