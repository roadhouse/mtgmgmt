class CreatePrice < ActiveRecord::Migration[4.2]
  def change
    create_table :prices do |t|
      t.references :card, index: true
      t.decimal :value
      t.string :source
      t.timestamps
    end
  end
end
