class AddListToDeck < ActiveRecord::Migration[4.2]
  enable_extension 'citext'

  def change
    add_column :decks, :list, :jsonb
  end
end
