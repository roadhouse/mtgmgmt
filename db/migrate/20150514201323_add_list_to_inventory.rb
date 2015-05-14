class AddListToInventory < ActiveRecord::Migration
  def change
    add_column :inventories, :list, :string
  end
end
