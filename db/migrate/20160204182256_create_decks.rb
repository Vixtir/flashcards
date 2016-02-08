class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :status, default: "inactive"

      t.timestamps null: false
    end
  end
end
