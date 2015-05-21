class CreatePrice < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :card, index: true
      t.decimal :value
    end
  end
end
