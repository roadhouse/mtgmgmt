class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.references :user
      t.string :name
      t.jsonb :list

      t.timestamps null: false
    end
  end
end
