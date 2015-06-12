class ChangeStringToInt < ActiveRecord::Migration
  def change
    change_column :cards, :power, "integer USING CAST(power AS integer)"
  end
end
