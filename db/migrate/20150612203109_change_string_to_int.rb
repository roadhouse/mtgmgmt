class ChangeStringToInt < ActiveRecord::Migration[4.2]
  def change
    change_column :cards, :power, "integer USING CAST(power AS integer)"
  end
end
