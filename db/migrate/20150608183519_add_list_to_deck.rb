class AddListToDeck < ActiveRecord::Migration
  enable_extension 'citext'

  def change
    add_column :decks, :list, :jsonb
  end
end
