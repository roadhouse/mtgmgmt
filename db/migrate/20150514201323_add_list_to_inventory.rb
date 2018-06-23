class AddListToInventory < ActiveRecord::Migration[4.2]
  def change
    add_column :inventories, :list, :string
  end
end
