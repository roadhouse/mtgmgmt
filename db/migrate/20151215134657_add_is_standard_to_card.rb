class AddIsStandardToCard < ActiveRecord::Migration
  def change
    add_column :cards, :is_standard, :boolean
  end
end
