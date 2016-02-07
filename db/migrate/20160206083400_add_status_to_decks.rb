class AddStatusToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :status, :string, default: "inactive"
  end
end
