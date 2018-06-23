class CreateCollections < ActiveRecord::Migration[4.2]
  def change
    create_table :collections do |t|
      t.references :user
      t.string :name
      t.jsonb :list

      t.timestamps null: false
    end
  end
end
