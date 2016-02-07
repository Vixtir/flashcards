class AddTitleToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :title, :string
  end
end
