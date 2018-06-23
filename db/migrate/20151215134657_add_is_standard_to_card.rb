class AddIsStandardToCard < ActiveRecord::Migration[4.2]
  def change
    add_column :cards, :is_standard, :boolean
  end
end
