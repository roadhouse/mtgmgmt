class ChangeQuantityToCopies < ActiveRecord::Migration
  def change
    rename_column :inventories, :quantity, :copies
  end
end
